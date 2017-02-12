require 'pry'

class Transfer
  attr_accessor :name1, :name2, :status
  attr_reader :sender, :receiver, :amount

  def initialize(name1, name2, amount)
    @sender = name1
    @receiver = name2
    @status = 'pending'
    @amount = amount
  end

  def valid?
    if @sender.valid? && @receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    if valid? && @sender.balance > amount && @status == 'pending'
      @sender.balance -= amount
      @receiver.deposit(amount)
      @status = 'complete'
    else
      @status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if valid? && @sender.balance > amount && @status == 'complete'
      @receiver.balance -= amount
      @sender.deposit(amount)
      @status = 'reversed'
    end
  end
end
