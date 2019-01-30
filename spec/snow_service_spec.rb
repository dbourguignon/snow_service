# frozen_string_literal: true

RSpec.describe SnowService do
  it 'has a version number' do
    expect(SnowService::VERSION).not_to be nil
  end

  describe '.call' do
    let(:service) do
      Class.new(SnowService::Base) do
        def perform
        end
      end
    end

    it "returns an instance of the service" do
      expect(service.call).to be_kind_of(service)
    end

    context "without defining #perform" do
      let(:service) do
        Class.new(SnowService::Base) do
        end
      end

      it "raise an error" do
        expect{ service.call }.to raise_error(RuntimeError, "You must implement perform method")
      end
    end

    context "with arguments" do
      let(:service) do
        Class.new(SnowService::Base) do
          def perform
          end

          def result
            @params
          end
        end
      end

      it "pass call arguments to the initializer" do
        expect(service.call("arg1", "arg2", params1: "params2").result).to contain_exactly(
          "arg1",
          "arg2",
          params1: "params2"
        )
      end
    end

    context "with result method" do
      let(:service) do
        Class.new(SnowService::Base) do
          def perform
            @var = "test"
          end

          def result
            @var = "test2"
          end
        end
      end

      it "freeze the instance" do
        expect{ service.call.result }.to raise_error(FrozenError)
      end
    end
  end
end
