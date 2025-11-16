import '../models/content.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/qna.dart';
import '../models/user.dart';

class MockDataService {
  const MockDataService();

  List<String> get crops => const [
        'Arhar',
        'Paddy',
        'Maize',
        'Wheat',
        'Vegetables',
      ];

  List<String> get districts => const [
        'Palamu',
        'Ramgarh',
        'Hazaribagh',
        'Ranchi',
        'Khunti',
      ];

  List<Product> get products => const [
        // Seeds
        Product(
          id: 'PUSA-ARHAR-16',
          name: 'Pusa Arhar-16 (Certified Seeds)',
          shortDescription: 'High-yield arhar variety suitable for semi-arid regions.',
          longDescription:
              'Pusa Arhar-16 is a drought tolerant pigeon pea variety widely recommended in Eastern India. '
              'Seed rate: 12-15 kg/ha. For best results apply starter dose of DAP and follow integrated pest management.',
          category: ProductCategory.seeds,
          price: 189,
          rating: 4.8,
          imageUrls: ['https://images.unsplash.com/photo-1593113598332-cd288d649433?w=600&h=400&fit=crop'],
          tags: ['certified', 'highYield', 'arhar'],
        ),
        Product(
          id: 'PADDY-SEEDS-50KG',
          name: 'Paddy Seeds - Swarna (50kg)',
          shortDescription: 'High-yielding paddy variety with excellent grain quality.',
          longDescription:
              'Swarna is a popular paddy variety known for its high yield and good grain quality. '
              'Matures in 140-145 days. Suitable for medium to low land conditions. Seed rate: 20-25 kg/ha.',
          category: ProductCategory.seeds,
          price: 1250,
          rating: 4.7,
          imageUrls: ['https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=600&h=400&fit=crop'],
          tags: ['paddy', 'highYield', 'certified'],
        ),
        Product(
          id: 'WHEAT-SEEDS-50KG',
          name: 'Wheat Seeds - HD-3086 (50kg)',
          shortDescription: 'Premium wheat variety with high protein content.',
          longDescription:
              'HD-3086 is a high-yielding wheat variety suitable for irrigated conditions. '
              'Matures in 120-125 days. Excellent for roti making. Seed rate: 100 kg/ha.',
          category: ProductCategory.seeds,
          price: 1800,
          rating: 4.6,
          imageUrls: ['https://images.unsplash.com/photo-1595855739205-7a5b9c4e0b8e?w=600&h=400&fit=crop'],
          tags: ['wheat', 'highProtein', 'certified'],
        ),
        Product(
          id: 'MAIZE-SEEDS-10KG',
          name: 'Maize Seeds - Hybrid (10kg)',
          shortDescription: 'High-yield hybrid maize seeds for better productivity.',
          longDescription:
              'Premium hybrid maize seeds with excellent germination rate. '
              'Matures in 90-95 days. Suitable for kharif and rabi seasons. Seed rate: 20 kg/ha.',
          category: ProductCategory.seeds,
          price: 450,
          rating: 4.5,
          imageUrls: ['https://images.unsplash.com/photo-1501594907352-04cda38ebc29?w=600&h=400&fit=crop'],
          tags: ['maize', 'hybrid', 'highYield'],
        ),
        Product(
          id: 'VEGETABLE-SEEDS-MIX',
          name: 'Vegetable Seeds Mix Pack',
          shortDescription: 'Mixed pack of popular vegetable seeds for kitchen garden.',
          longDescription:
              'Contains seeds of tomato, brinjal, chilli, okra, and cucumber. '
              'All seeds are open-pollinated and suitable for home gardening. Best for small plots.',
          category: ProductCategory.seeds,
          price: 299,
          rating: 4.4,
          imageUrls: ['https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=600&h=400&fit=crop'],
          tags: ['vegetables', 'kitchenGarden', 'mixed'],
        ),
        Product(
          id: 'MUSTARD-SEEDS-5KG',
          name: 'Mustard Seeds - Pusa Bold (5kg)',
          shortDescription: 'High-yield mustard variety for oil production.',
          longDescription:
              'Pusa Bold is a popular mustard variety with high oil content. '
              'Matures in 100-110 days. Suitable for rabi season. Seed rate: 5-6 kg/ha.',
          category: ProductCategory.seeds,
          price: 350,
          rating: 4.3,
          imageUrls: ['https://images.unsplash.com/photo-1606914469633-bd39247daa62?w=600&h=400&fit=crop'],
          tags: ['mustard', 'oil', 'rabi'],
        ),
        // Fertilizers
        Product(
          id: 'IFFCO-UREA-45',
          name: 'IFFCO Urea (45kg)',
          shortDescription: 'Premium nitrogen fertilizer for healthy crop growth.',
          longDescription:
              'IFFCO Urea contains 46% nitrogen and is ideal for basal and top dressing across major crops. '
              'Apply along with recommended phosphorous and potash for balanced nutrition.',
          category: ProductCategory.fertilizer,
          price: 266,
          rating: 4.6,
          imageUrls: ['https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=600&h=400&fit=crop'],
          tags: ['nitrogen', 'fertilizer'],
        ),
        Product(
          id: 'DAP-50KG',
          name: 'DAP Fertilizer (50kg)',
          shortDescription: 'Di-Ammonium Phosphate for balanced nutrition.',
          longDescription:
              'DAP contains 18% nitrogen and 46% P2O5. Ideal for basal application in all crops. '
              'Promotes root development and early plant growth. Apply at sowing or transplanting.',
          category: ProductCategory.fertilizer,
          price: 1350,
          rating: 4.7,
          imageUrls: ['https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=600&h=400&fit=crop'],
          tags: ['phosphorous', 'nitrogen', 'fertilizer'],
        ),
        Product(
          id: 'MOP-50KG',
          name: 'MOP - Muriate of Potash (50kg)',
          shortDescription: 'Potassium fertilizer for better crop quality.',
          longDescription:
              'MOP contains 60% K2O and is essential for fruit and grain development. '
              'Improves crop quality, disease resistance, and shelf life. Apply during flowering stage.',
          category: ProductCategory.fertilizer,
          price: 1200,
          rating: 4.5,
          imageUrls: ['https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=600&h=400&fit=crop'],
          tags: ['potash', 'potassium', 'fertilizer'],
        ),
        Product(
          id: 'NPK-19-19-19',
          name: 'NPK 19:19:19 (50kg)',
          shortDescription: 'Balanced NPK fertilizer for all crops.',
          longDescription:
              'Complete fertilizer with balanced nitrogen, phosphorous, and potash. '
              'Suitable for foliar application and fertigation. Promotes overall plant growth and yield.',
          category: ProductCategory.fertilizer,
          price: 1450,
          rating: 4.6,
          imageUrls: ['https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=600&h=400&fit=crop'],
          tags: ['balanced', 'npk', 'fertilizer'],
        ),
        Product(
          id: 'ORGANIC-MANURE-50KG',
          name: 'Organic Manure (50kg)',
          shortDescription: 'Natural organic fertilizer for sustainable farming.',
          longDescription:
              'Well-decomposed organic manure rich in nutrients and beneficial microorganisms. '
              'Improves soil health and structure. Suitable for organic farming practices.',
          category: ProductCategory.fertilizer,
          price: 250,
          rating: 4.5,
          imageUrls: ['https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=600&h=400&fit=crop'],
          tags: ['organic', 'manure', 'sustainable'],
        ),
        // Pesticides
        Product(
          id: 'NEEM-OIL-1L',
          name: 'Neem Oil (1L)',
          shortDescription: 'Broad spectrum bio-pesticide for organic farming.',
          longDescription:
              'Cold pressed neem oil with 1500 ppm azadirachtin. Controls sucking pests and acts as a growth regulator. '
              'Spray during evening hours for best efficacy.',
          category: ProductCategory.pesticide,
          price: 399,
          rating: 4.5,
          imageUrls: ['https://images.unsplash.com/photo-1615485925506-bab5e5e4c754?w=600&h=400&fit=crop'],
          tags: ['organic', 'pestManagement'],
        ),
        // Machinery
        Product(
          id: 'KNAPSACK-16L',
          name: 'Knapsack Sprayer (16L)',
          shortDescription: 'Durable 16-litre knapsack sprayer with dual nozzles.',
          longDescription:
              'Ergonomic design with high-density polyethylene tank. Comes with brass lance, dual nozzle options, '
              'and padded straps for all-day spraying comfort.',
          category: ProductCategory.machinery,
          price: 1449,
          rating: 4.4,
          imageUrls: ['https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=600&h=400&fit=crop'],
          tags: ['equipment', 'sprayer'],
        ),
        // Services
        Product(
          id: 'DRIP-KIT-ACRE',
          name: 'Drip Irrigation Kit (1 Acre)',
          shortDescription: 'Complete drip kit with venturi and filters.',
          longDescription:
              'Inline drip kit including mainline pipes, inline drippers, venturi injector, filters, and connectors. '
              'Reduces water consumption by up to 50% and improves fertilizer use efficiency.',
          category: ProductCategory.services,
          price: 8799,
          rating: 4.7,
          imageUrls: ['https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=600&h=400&fit=crop'],
          tags: ['irrigation', 'waterSaving'],
        ),
      ];

  List<Product> recommendationsFor(String crop, String district) {
    // Simple heuristic: filter by tags or fallback to top rated
    if (crop.toLowerCase().contains('arhar')) {
      return products.where((product) => product.tags.contains('arhar')).toList();
    }
    if (crop.toLowerCase().contains('paddy')) {
      return products.where((product) => product.category == ProductCategory.fertilizer).toList();
    }
    return products.where((product) => product.rating >= 4.5).take(3).toList();
  }

  List<Order> get orders => [
        Order(
          id: '#KS-10293',
          products: [products.first, products[1]],
          placedAt: DateTime.now().subtract(const Duration(days: 12)),
          status: OrderStatus.delivered,
          total: 455.0,
        ),
        Order(
          id: '#KS-10311',
          products: [products[2]],
          placedAt: DateTime.now().subtract(const Duration(days: 4)),
          status: OrderStatus.processing,
          total: 399.0,
        ),
      ];

  List<QnaItem> get qnaItems => [
        QnaItem(
          id: 'Q-101',
          question: 'How much seed rate is required for Arhar in Palamu?',
          answer: 'Use 12-15 kg certified seeds per hectare. Maintain 60x20 cm spacing and use raised bed planting.',
          askedBy: 'Sita Devi, Palamu',
          expertName: 'Dr. Verma',
          answeredAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        QnaItem(
          id: 'Q-102',
          question: 'Best nutrient schedule for paddy at tillering stage?',
          answer: 'Apply 25 kg urea and 17 kg MOP per acre along with foliar spray of 1% zinc sulphate.',
          askedBy: 'Mahadev Oraon, Ramgarh',
          expertName: 'Anita Lakra',
          answeredAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ];

  List<LearningContent> get learnContent => const [
        LearningContent(
          id: 'L-101',
          title: 'Integrated Pest Management in Pulses',
          summary: 'Step-by-step guide to manage sucking pests, pod borers, and wilt complex in pulses.',
          imageUrl: 'https://placehold.co/600x400/d9f99d/123?text=IPM',
          type: 'Article',
          duration: '6 min read',
        ),
        LearningContent(
          id: 'L-102',
          title: 'How to set up low-cost drip irrigation',
          summary: 'Video tutorial covering design layout, filtration, fertigation and maintenance tips.',
          imageUrl: 'https://placehold.co/600x400/a855f7/123?text=Drip',
          type: 'Video',
          duration: '12 min',
        ),
        LearningContent(
          id: 'L-103',
          title: 'Post-harvest storage practices for maize',
          summary: 'Reduce losses by adopting hermetic storage bags and improved drying techniques.',
          imageUrl: 'https://placehold.co/600x400/f97316/123?text=Storage',
          type: 'Guide',
          duration: '8 min read',
        ),
      ];

  List<Map<String, dynamic>> get partners => const [
        {'name': 'Betla FPO Limited', 'farmers': 1200},
        {'name': 'Ramgarh FPO', 'farmers': 700},
        {'name': 'Koyal Agro Collective', 'farmers': 2000},
        {'name': 'Pandu FPO Federation', 'farmers': 2520},
      ];

  UserProfile get defaultUser => const UserProfile(
        id: 'USER-1',
        name: 'Sunita Kumari',
        phone: '+91 98765 43210',
        preferredLanguageCode: 'hi',
        primaryCrop: 'Arhar',
        district: 'Palamu',
      );
}

