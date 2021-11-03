json.extract! room, :id, :name, :channel_id, :channel_type
json.notices room.notices, partial: "rooms/notice", as: :notice