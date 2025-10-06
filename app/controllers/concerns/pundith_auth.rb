# frozen_string_literal: true

module PunditAuth
  extend ActiveSupport::Concern
  include Pundit::Authorization

  # included do
  #   before_render :verify_authorized, except: [:index, :campaign_objective_overview]
  #   before_render :verify_policy_scoped, only: [:index, :campaign_objective_overview]
  # end

  def policy_scope(scope, policy_scope_class: nil)
    super(scope, policy_scope_class: policy_scope_class || policy_class::Scope)
  end

  def authorize(record, method = nil, opts = {})
    opts[:policy_class] ||= policy_class
    super(record, method, **opts)
  end

  def policy_class
    self.class.name.underscore.gsub('_controller', '_policy').camelize.constantize
  end

  private

  def namespace
    self.class.name.deconstantize.underscore.split('/').map(&:to_sym)
  end
end
