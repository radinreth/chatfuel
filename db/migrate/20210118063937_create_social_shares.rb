class CreateSocialShares < ActiveRecord::Migration[6.0]
  def change
    create_table :social_shares do |t|
      t.string :site_name

      t.timestamps
    end
  end
end
