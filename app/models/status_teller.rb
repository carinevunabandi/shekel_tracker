class StatusTeller

  def self.current(budget, total_speding)
    (budget > total_speding)? 'Within' : 'Beyond'
  end
end
