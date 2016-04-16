class AddPositiveToRapidfireQuestions < ActiveRecord::Migration
  def change
    add_column :rapidfire_questions, :positive, :boolean, :default => true
  end
end
