class Course < ApplicationRecord
  require 'csv'

  has_many :enrollments
  has_many :users, through: :enrollments

  validates :name, presence: true


  def bulk_enroll(csv_file)
    CSV.foreach(csv_file.path, headers: true) do |row, index|
      self.validate_csv_headers(row.headers) if index = 0

      row = row.to_hash

      u = User.find_by(email: row['email'])
      if not u
        u = User.invite!(row)
      end

      begin
        Enrollment.create course: self, user: u
      rescue ActiveRecord::RecordNotUnique
      end

    end
  end

  def validate_csv_headers(headers)
    valid_headers = %w{first_name last_name email}
    unexpected = headers - valid_headers
    missing = valid_headers - headers
    if not unexpected.empty?
      raise "Unexpected columns: #{unexpected}"
    elsif not missing.empty?
      raise "Missing columsn: #{missing}"
    end
  end

end
