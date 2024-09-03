require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:videos) }
  end

  describe "validations" do
    context "when valid all" do
      let(:user) { FactoryBot.build :user }

      it "should return true" do
        expect(user.valid?).to be_truthy
      end
    end

    context "when instance invalid" do
      context "validate email" do
        context "when email nil" do
          let(:user) { FactoryBot.build :user, email: nil }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:email].first.has_value?(:blank)).to be_truthy
          end
        end

        context "when email blank" do
          let(:user) { FactoryBot.build :user, email: '' }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:email].first.has_value?(:blank)).to be_truthy
          end
        end

        context "when email too long" do
          let(:user) { FactoryBot.build :user, email: ("x" * Settings.validate.user.email.max_length) + "@example.com" }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:email].first.has_value?(:too_long)).to be_truthy
          end
        end

        context "when email invalid format" do
          let(:user) { FactoryBot.build :user, email: "example" }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:email].first.has_value?(:invalid)).to be_truthy
          end
        end
      end

      context "validate username" do
        context "when username nil" do
          let(:user) { FactoryBot.build :user, username: nil }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:username].first.has_value?(:blank)).to be_truthy
          end
        end

        context "when username blank" do
          let(:user) { FactoryBot.build :user, username: '' }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:username].first.has_value?(:blank)).to be_truthy
          end
        end

        context "when username too long" do
          let(:user) { FactoryBot.build :user, username: ("x" * Settings.validate.user.username.max_length) + "_this_is_too_long" }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:username].first.has_value?(:too_long)).to be_truthy
          end
        end
      end

      context "validate password" do
        context "when password nil" do
          let(:user) { FactoryBot.build :user, password: nil }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:password].first.has_value?(:blank)).to be_truthy
          end
        end

        context "when password blank" do
          let(:user) { FactoryBot.build :user, password: '' }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:password].first.has_value?(:blank)).to be_truthy
          end
        end

        context "when password too short" do
          let(:user) { FactoryBot.build :user, password: ("x" * (Settings.validate.user.password.min_length - 1)) }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:password].first.has_value?(:too_short)).to be_truthy
          end
        end

        context "when password too long" do
          let(:user) { FactoryBot.build :user, password: ("x" * Settings.validate.user.password.max_length) + "_this_is_too_long" }

          it "should return false" do
            expect(user.valid?).to be_falsy
            expect(user.errors.details[:password].first.has_value?(:too_long)).to be_truthy
          end
        end
      end
    end
  end

  describe "callbacks" do
    context "before_save" do
      let(:user) { FactoryBot.build :user, email: "USER@EXAMPLE.COM" }

      it "should downcases the email before saving" do
        user.save
        expect(user.reload.email).to eq("user@example.com")
      end
    end
  end
end
