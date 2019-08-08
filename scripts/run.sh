for file in perseus_1/*.txt
do
  python file-parsing.py "$file" perseus_txt_out/"$file"
done
