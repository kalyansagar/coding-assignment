# enter the below code into shell 1 to serialize the object and store in a file
File.open("apple.txt", "w"){|to_file| Marshal.dump(apple, to_file)}
