class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    self.sender.valid? &&
    self.receiver.valid? &&
    self.sender.balance >  self.amount ? true : false
  end

  def execute_transaction
    if self.valid? && self.status == 'pending'
      sender.withdraw(self.amount)
      receiver.deposit(self.amount)
      self.status = 'complete'
    else
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == 'complete'
      sender.deposit(self.amount)
      receiver.withdraw(self.amount)
      self.status = 'reversed'
    else
      "Cannot reverse transaction"
    end
  end


end
