BEGIN {FS=" "; filename = ARGV[2]}
{gsub(/feiticeir/,"padeir"); gsub(/brux/,"pasteleir"); print}
END {}
