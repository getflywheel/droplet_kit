# frozen_string_literal: true

module DropletKit
  class LoadBalancerMapping
    include Kartograph::DSL

    kartograph do
      mapping LoadBalancer
      root_key singular: 'load_balancer', plural: 'load_balancers', scopes: [:read]

      scoped :read do
        property :id
        property :ip
        property :status
        property :created_at
        property :region, include: RegionMapping
        property :size
        property :size_unit
        property :vpc_uuid
      end

      scoped :read, :update, :create do
        property :name
        property :algorithm
        property :tag
        property :redirect_http_to_https
        property :enable_proxy_protocol
        property :enable_backend_keepalive
        property :droplet_ids
        property :sticky_sessions, include: StickySessionMapping
        property :health_check, include: HealthCheckMapping
        property :forwarding_rules, plural: true, include: ForwardingRuleMapping
        property :disable_lets_encrypt_dns_records
      end

      scoped  :update, :create do
        property :region
        property :size
        property :size_unit
      end

      scoped :create do
        property :vpc_uuid
      end
    end
  end
end
