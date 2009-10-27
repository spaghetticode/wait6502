class CreateHardware < ActiveRecord::Migration
  def self.up
    create_table :hardware do |t|
      # sti enabler:
      t.string :type, :null => false
      # common fields:
      t.string :name, :null => false
      t.string :code
      t.text :notes
      t.integer :manufacturer_id, :null => false
      t.integer :production_start, :production_stop
      # computer fields:
      t.string :computer_type_id, :codename
      t.text :text_modes, :graphic_modes, :sound
      t.string :builtin_language_id
      t.string :ram, :vram, :rom
      # peripheral fields:
      t.string :peripheral_type_id
    end
  end

  def self.down
    drop_table :hardware
  end
end
