# TODO: save as env
# VideoInfo.provider_api_keys = { youtube: "AIzaSyBMkHp4ww4c-MFxm9OmbB_4J0o0opQAWKo" }

if Rails.application.credentials.youtube_api_key
  VideoInfo.provider_api_keys = { youtube: Rails.application.credentials.youtube_api_key }
end
