require 'account'

describe Account do
  describe "#initialize" do
    context "when passing valid input"  do
      let(:account){Account.new("1234567891")}
      it "creates a new account" do
        expect(account).to be_an_instance_of(Account)
      end
    end
    context "when passing invalid input" do
      let(:account1){Account.new("12345891")}
      it "raise an error when passing a new account with less than 10 digits" do
        expect{account1}.to raise_error(StandardError, "InvalidAccountNumberError")
      end
    end
  end

  describe "#transactions" do
    context "when using default starting_balance" do
      let(:account){Account.new("1234567891")}
      it "returns the default starting_balance" do
        expect(account.transactions).to match([0])
      end
    end

    context "when initialized with a starting_balance" do
      let(:account) { Account.new("1234567890", 100) }
      it "returns the specified balance" do
        expect(account.balance).to match(100)
      end
    end
  end

  describe "#balance" do
    context "when starting_balance is 0" do
      let(:account){Account.new("1234567891")}
      it "is 0" do    
        expect(account.balance).to match(0)
      end 
    end
  end

  describe "#account_number" do
    context "when account number has mask" do
      let(:account){Account.new("3452891210", 100)}
      it "masks the number of the account" do
        expect(account.acct_number).to match("******1210")
      end
    end
  end

  describe "deposit!" do
    context "when an amount is positive" do
      let(:account){Account.new("3452891210", 100)}
      it "requires a positive amount" do
        expect{account.deposit!(-1)}.to raise_error(StandardError, "NegativeDepositError")
      end
    end
    context "when account balance is increased" do
      let(:account){Account.new("3452891210", 100)}
      it "increases the balance of the account" do
        account.deposit!(100)
        expect(account.balance).to match(200)
      end
    end
  end

  describe "#withdraw!" do
    context "when the balance is decreased" do
      let(:account){Account.new("3452891210", 200)}
      it "decreases the balance" do
        account.withdraw!(50)
        expect(account.balance).to match(150)
      end
    end
    context "when withdraw amount is bigger than balance" do
      let(:account){Account.new("3452891210", 200)}
      it "throws an OverdraftError when withdraw amount is bigger than balance" do
        expect{account.withdraw!(400)}.to raise_error(StandardError, "OverdraftError")
      end
    end
    context "when positive amounts are substracted" do
      let(:account){Account.new("3452891210", 200)}
      it "substracts positive amounts" do
        account.withdraw!(-100) 
        expect(account.balance).to match(100)  
      end
    end
  end
end