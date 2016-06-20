class AddFailedAttemptsToUser < ActiveRecord::Migration
  def change
    add_column :users, :failed_attempts, :integer, default: 0
  end
end
