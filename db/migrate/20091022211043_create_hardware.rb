class CreateHardware < ActiveRecord::Migration
  def self.up
    create_table :hardware do |t|
      # sti enabler:
      t.string :type, :null => false
      # common fields:
      t.string :name, :null => false
      t.string :code, :notes
      t.integer :manufacturer_id, :null => false
      t.integer :production_start, :production_stop
      # computer fields:
      t.string :comp_type_id, :codename
      t.string :text_modes, :graphics_modes, :sound
      t.string :builtin_language_id
      # peripheral fields:
      t.string :per_type
    end
  end

  def self.down
    drop_table :hardware
  end
end
