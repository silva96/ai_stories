# frozen_string_literal: true

Rails.application.config.active_storage.variant_processor = :vips
Rails.application.config.active_storage.resolve_model_to_route = :rails_storage_proxy
