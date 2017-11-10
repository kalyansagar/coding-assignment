namespace :coding_assignment do
  desc "fills the given apples into baskets available"
  task :add_apple_to_basket, [:variety, :count] => [:environment] do |task, args|
    applesLeft = args[:count].to_i

    # Find baskets with free space for apples of args[:variety] or empty
    query = Basket.select("baskets.* , COUNT(apples.basket_id) AS filled_count")
                .joins("LEFT JOIN apples ON apples.basket_id = baskets.id")
                .group("baskets.id")
                .having("(apples.variety = '#{args[:variety]}' AND filled_count < capacity) OR filled_count = 0")
                .order("baskets.created_at ASC")

    # Looping through available baskets to fill in apples
    query.find_each do |basket|
      while basket.filled_count < basket.capacity && applesLeft > 0

        # Create an apple of the given variety and add to basket
        apple = Apple.new
        apple.basket_id = basket.id
        apple.variety = args[:variety]
        apple.save

        # Update basket's fill rate
        basket.filled_count = basket.filled_count + 1
        basket.fill_rate = basket.filled_count.to_f / basket.capacity.to_f * 100.0

        applesLeft = applesLeft - 1
      end

      basket.save

      if applesLeft == 0
        break
      end
    end

    if applesLeft > 0
      puts "All baskets are full. We couldn't find the place for #{applesLeft} apples"
    else
      puts "Done"
    end

    # enter the below code into shell 2 to read the serialized object from the file and load into variable
    apple = File.open("apple.txt", "r"){|from_file| Marshal.load(from_file)}


  end
end
