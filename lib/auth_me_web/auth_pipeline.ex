defmodule AuthMe.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :AuthMe,
  module: AuthMe.Guardian,
  error_handler: AuthMe.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end