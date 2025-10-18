class CreateBarbers < ActiveRecord::Migration[7.2]
  def change
    create_table :barbers do |t|
      t.text :name
    end

    Barber.create :name => "Jessie Pinkman"
    Barber.create :name => "Gus Fring"
    Barber.create :name => "Walter White"

  end
end
