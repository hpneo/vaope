Rails.application.config.middleware.use OmniAuth::Builder do
	provider :twitter, 'pOaB8ysfUXpeCNVKCVwg', 'FintdoLblQTnANGBcSJLz6aABrC9fWoADxjS3l0JqM'
  provider :facebook, '271877906163837', '6e13721de13111ed08955c300aff3d0b', :scope => 'email,create_event,offline_access,publish_stream'
end