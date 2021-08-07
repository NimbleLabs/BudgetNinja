json.extract! invitation, :id, :email, :family_id, :uuid, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
