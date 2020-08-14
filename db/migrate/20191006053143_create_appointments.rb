class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
    	t.string :p_id
    	t.string :p_name
		t.string :phone
		t.string :slot_name
                 t.date:doa
		

      t.timestamps
    end
  end
end
