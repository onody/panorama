class C3LineChart
  attr_accessor :header, :row

  def initialize(by, passed_count)
    @header, @row = [], []
    @by, @passed_count = by, passed_count
    set_x(by, passed_count)
  end

  def add(title, data)
    @row << [title].concat(data)
  end

  def make
    h = []
    case @by
    when :month then
      h = @header.map{|h| h.strftime("%Y/%m") }
    when :day then
      h = @header.map{|h| h.strftime("%m/%d") }
    when :hour then
      h = @header.map{|h| h.strftime("%m/%d %H") }
    end
    header = ["x"].concat(h)
    [header].concat(@row)
  end

  private

    def set_x(by, passed_count)
      case by
      when :month then
        passed_count.to_i.downto(1) do |i|
          @header << Time.now.ago(i.months)
        end
      when :day then
        passed_count.to_i.downto(1) do |i|
          @header << Time.now.ago(i.days).change(hour: 0, min: 0, sec: 0)
        end
      when :hour then
        passed_count.to_i.downto(1) do |i|
          @header << Time.now.ago(i.hours).change(min: 0, sec: 0)
        end
      else
        return nil
      end
      @header
    end
end
