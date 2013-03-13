module LazyConstMixins
  def defines_consts(*consts)
    consts.each do |const|
      it "defined constant #{const} is an instance of #{described_class}" do
        described_class.public_send(const.to_sym).should be_instance_of(described_class)
      end
    end
  end
  alias_method :defines_const, :defines_consts
end

RSpec.configure do |config|
  config.extend LazyConstMixins
end
