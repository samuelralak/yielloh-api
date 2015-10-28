##
#  Copyright 2012 Twitter, Inc
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
##

class CreateReputationSystem < ActiveRecord::Migration
  def self.up
    create_table :rs_evaluations, id: :uuid do |t|
      t.string      :reputation_name
      t.uuid        :source_id
      t.string      :source_type
      t.uuid        :target_id
      t.string      :target_type
      t.float       :value, :default => 0
      t.timestamps
    end

    add_index :rs_evaluations, :reputation_name
    add_index :rs_evaluations, [:target_id, :target_type]
    add_index :rs_evaluations, [:source_id, :source_type]

    create_table :rs_reputations, id: :uuid do |t|
      t.string      :reputation_name
      t.float       :value, :default => 0
      t.string      :aggregated_by
      t.uuid        :target_id
      t.string      :target_type
      t.boolean     :active, :default => true
      t.timestamps
    end

    add_index :rs_reputations, :reputation_name
    add_index :rs_reputations, [:target_id, :target_type]

    create_table :rs_reputation_messages, id: :uuid do |t|
      t.uuid        :sender_id
      t.string      :sender_type
      t.uuid        :receiver_id
      t.float       :weight, :default => 1
      t.timestamps
    end

    add_index :rs_reputation_messages, [:sender_id, :sender_type]
    add_index :rs_reputation_messages, :receiver_id
  end

  def self.down
    drop_table :rs_evaluations
    drop_table :rs_reputations
    drop_table :rs_reputation_messages
  end
end
