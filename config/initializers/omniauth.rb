Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'tVVaPgg7tC6tmqmONQDBg', 'aKud6KgfWLC11zch7apR7bx8aF8Db24Q4uSHkkJQ'
  provider :github, 'f5d2c4403290631dc947', '542b5387ce92afa299e6eb22b4beaf782147f6d2', scope: "user"
  provider :linkedin, '23qwmsn2dsvj', 'jxlX53ed2hPYQgCR'
end