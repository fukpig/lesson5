class FileNotFound < ArgumentError
  attr_reader :filename
    def initialize(filename)
      @filename = filename
      super("File #{filename} not found")
  end
end
