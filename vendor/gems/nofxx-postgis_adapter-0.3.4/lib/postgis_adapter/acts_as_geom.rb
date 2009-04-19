# #
# PostGIS Adapter
#
#
# http://github.com/nofxx/postgis_adapter
#
module PostgisFunctions
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods

    # acts_as_geom :geom
    def acts_as_geom(*columns)
      cattr_accessor :postgis_geoms
      geoms = columns.map do |g|
        geom_type = get_geom_type(g)
        case geom_type
        when :point
          send :include, PointFunctions
        when :polygon
          send :include, PolygonFunctions
        when :line_string
          send :include, LineStringFunctions
        end
        g
      end
      self.postgis_geoms = {:columns => geoms}#, :opts => options}
    end

    def get_geom_type(column)
      self.columns.select { |c| c.name == column.to_s}.first.geometry_type
    rescue ActiveRecord::StatementInvalid => e
      nil
    end
  end
end

ActiveRecord::Base.send :include, PostgisFunctions
