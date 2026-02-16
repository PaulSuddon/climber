puts "Seeding destinations..."

# Climbing Destinations
climbing_destinations = [
  {
    name: "La Pedriza",
    description: "One of the most famous granite climbing areas in Europe. Located in the Sierra de Guadarrama National Park, it offers hundreds of routes from easy slabs to challenging cracks. Perfect for both beginners and experienced climbers.",
    activity_type: :climbing,
    latitude: 40.7528,
    longitude: -3.8892,
    difficulty_level: "All levels",
    address: "Sierra de Guadarrama, Manzanares el Real, Madrid",
    image_url: "https://images.unsplash.com/photo-1522163182402-834f871fd851?w=800&q=80"
  },
  {
    name: "Patones",
    description: "Excellent limestone sport climbing area north of Madrid. Features steep walls with crimpy holds and technical routes. The rock quality is superb and the setting is beautiful.",
    activity_type: :climbing,
    latitude: 40.8667,
    longitude: -3.4667,
    difficulty_level: "Intermediate to Advanced",
    address: "Patones de Arriba, Madrid",
    image_url: "https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800&q=80"
  },
  {
    name: "La Cabrera",
    description: "Granite bouldering paradise just 50km from Madrid. Home to thousands of boulder problems from V0 to V15. The area is known for its high-quality granite and beautiful mountain scenery.",
    activity_type: :climbing,
    latitude: 40.8653,
    longitude: -3.6108,
    difficulty_level: "All levels",
    address: "La Cabrera, Sierra Norte de Madrid",
    image_url: "https://images.unsplash.com/photo-1564769662533-4f00a87b4056?w=800&q=80"
  },
  {
    name: "El Escorial",
    description: "Historic climbing area near the famous monastery. Offers multi-pitch granite routes with stunning views. A great option for those looking for longer adventures close to Madrid.",
    activity_type: :climbing,
    latitude: 40.5833,
    longitude: -4.1167,
    difficulty_level: "Intermediate",
    address: "San Lorenzo de El Escorial, Madrid",
    image_url: "https://images.unsplash.com/photo-1551632811-561732d1e306?w=800&q=80"
  }
]

# Hiking Destinations
hiking_destinations = [
  {
    name: "Penalara",
    description: "The highest peak in the Madrid region at 2,428m. Offers spectacular views of the Sierra de Guadarrama. The hike passes through beautiful pine forests and alpine meadows with possible wildlife sightings.",
    activity_type: :hiking,
    latitude: 40.8514,
    longitude: -3.9556,
    difficulty_level: "Moderate to Difficult",
    address: "Puerto de Cotos, Sierra de Guadarrama",
    image_url: "https://images.unsplash.com/photo-1551632436-cbf8dd35adfa?w=800&q=80"
  },
  {
    name: "La Bola del Mundo",
    description: "A classic hike from Navacerrada with panoramic views. At 2,265m, the summit offers 360-degree views of the entire mountain range. Can be combined with other peaks for a longer day.",
    activity_type: :hiking,
    latitude: 40.7833,
    longitude: -4.0167,
    difficulty_level: "Moderate",
    address: "Puerto de Navacerrada, Madrid",
    image_url: "https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80"
  },
  {
    name: "Siete Picos",
    description: "A classic ridge walk with seven distinct peaks. One of the most popular hikes in the Sierra de Guadarrama. The trail offers great views and interesting rock formations throughout.",
    activity_type: :hiking,
    latitude: 40.7833,
    longitude: -4.0500,
    difficulty_level: "Moderate",
    address: "Puerto de Navacerrada to Puerto de la Fuenfria",
    image_url: "https://images.unsplash.com/photo-1483728642387-6c3bdd6c93e5?w=800&q=80"
  },
  {
    name: "El Yelmo",
    description: "The iconic dome-shaped peak in La Pedriza. A rewarding hike through unique granite landscapes. The summit scramble is exciting and offers amazing views of the entire Pedriza area.",
    activity_type: :hiking,
    latitude: 40.7500,
    longitude: -3.8833,
    difficulty_level: "Moderate",
    address: "La Pedriza, Manzanares el Real",
    image_url: "https://images.unsplash.com/photo-1454496522488-7a8e488e8606?w=800&q=80"
  }
]

all_destinations = climbing_destinations + hiking_destinations

all_destinations.each do |destination_data|
  destination = Destination.find_or_initialize_by(name: destination_data[:name])
  destination.description = destination_data[:description]
  destination.activity_type = destination_data[:activity_type]
  destination.latitude = destination_data[:latitude]
  destination.longitude = destination_data[:longitude]
  destination.difficulty_level = destination_data[:difficulty_level]
  destination.address = destination_data[:address]
  destination.image_url = destination_data[:image_url]
  destination.save!
end

puts "Created #{Destination.count} destinations!"
puts "Seeding complete!"
