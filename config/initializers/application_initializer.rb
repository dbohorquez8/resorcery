# this is for encoding and decoding our ids.
$hashids = Hashids.new(ENV['HASHIDS_ENCODING_SALT'], 8)
