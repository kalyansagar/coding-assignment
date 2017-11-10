# enter the below code into shell 2 to read the serialized object from the file and load into variable
apple = File.open("apple.txt", "r"){|from_file| Marshal.load(from_file)}
