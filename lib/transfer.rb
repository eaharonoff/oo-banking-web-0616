require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :amount, :status, :sender_after, :receiver_after
  attr_reader :run_transfer, :run_reverse
  def initialize(sender,receiver,amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
    @run_transfer = 0
    # @run_reverse = 0
  end

  def valid? 
    sender.valid? && receiver.valid?
  end

  def balance_validation
    sender.balance > self.amount
  end

  def execute_transaction
    if self.valid? && self.status == "pending" && self.balance_validation 
      self.sender_after = (self.sender.balance -= amount)  
      self.receiver_after = (self.receiver.balance += amount)
      self.status = "complete" 
    else
      self.status = "rejected" 
      "Transaction rejected. Please check your account balance."  
    end
  end
  def reverse_transfer
    if run_transfer == 1
      self.sender.balance = (self.sender_after += amount)
      self.receiver.balance = (self.receiver_after -= amount)
      self.status = "reversed" 
    end

  end
end
