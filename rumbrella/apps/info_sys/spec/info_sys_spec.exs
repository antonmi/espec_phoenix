defmodule InfoSysSpec do
  use ESpec
  alias InfoSys.Result

  defmodule TestBackend do
    def start_link(query, ref, owner, limit) do
      Task.start_link(__MODULE__, :fetch, [query, ref, owner, limit])
    end

    def fetch("result", ref, owner, _limit) do
      send(owner, {:results, ref, [%Result{backend: "test", text: "result"}]})
    end

    def fetch("none", ref, owner, _limit) do
      send(owner, {:results, ref, []})
    end

    def fetch("timeout", _ref, owner, _limit) do
      send(owner, {:backend, self()})
      :timer.sleep(:infinity)
    end
  end

  describe "&compute/2" do
    let :result, do: InfoSys.compute(query(), backends: [TestBackend])

    context "with result" do
      let :query, do: "result"
      it do: expect result() |> to(eq [%Result{backend: "test", text: "result"}])
    end

    context "with no result" do
      let :query, do: "none"
      it do: expect result() |> to(eq [])
    end

    context "with timeout" do
      let! :result, do: InfoSys.compute(query(), backends: [TestBackend], timeout: 10)
      let :query, do: "timeout"

      it do: expect result() |> to(eq [])

      before do
        assert_receive {:backend, backend_pid}
        ref = Process.monitor(backend_pid)
        {:shared, ref: ref}
      end

      it "checks messages" do
        ref = shared[:ref]
        assert_receive {:DOWN, ^ref, :process, _pid, _reason}
        refute_received {:DOWN, _, _, _, _}
        refute_received :timedout
      end
    end

    if Code.ensure_loaded?(ExUnit.CaptureServer) do
      context "with boom" do
        let :query, do: "boom"

        it "compute/2 discards backend errors" do
          capture_log(fn ->
            expect result() |> to(eq [])
            refute_received {:DOWN, _, _, _, _}
            refute_received :timedout
          end)
        end
      end
    end  
  end
end
