class TINValidator
    FORMATS = {
      'AU' => { 'au_abn' => /\A\d{11}\z/, 'au_acn' => /\A\d{9}\z/ },
      'CA' => { 'ca_gst' => /\A\d{9}RT\d{4}\z/ },
      'IN' => { 'in_gst' => /\A\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}Z\d{1}\z/ }
    }.freeze
  
    def initialize(country, number)
      @country = country
      @number = number
    end
  
    def validate
      format = find_format
  
      if format && @number.match?(format)
        { valid: true, formatted_tin: format_number }
      else
        { valid: false, errors: ["Invalid format or length for #{@country}"] }
      end
    end
  
    private
  
    def find_format
      FORMATS[@country]&.values&.first
    end
  
    def format_number
      case @country
      when 'AU'
        @number.gsub(/(\d{2})(\d{3})(\d{3})(\d{3})/, '\1 \2 \3 \4')
      else
        @number
      end
    end
  end
  