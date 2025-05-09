import 'package:core/api.dart';

import '../dto/benefit_category_dto.dart';
import 'benefits_api_endpoints.dart';

class BenefitsApiClient {
  const BenefitsApiClient(this._baseApiClient);
  final BaseApiClient _baseApiClient;

  Future<List<BenefitCategoryDto>> getBenefits() async {
    return benefitsTestData.map((json) => BenefitCategoryDto.fromJson(json as Map<String, dynamic>)).toList();
    final response = await _baseApiClient.get(BenefitsApiEndpoints.benefits);

    final jsonList = response.body as List<dynamic>;
    return jsonList.map((json) => BenefitCategoryDto.fromJson(json as Map<String, dynamic>)).toList();
  }
}

const benefitsTestData = [
  {
    "title": "Food & Drinks",
    "description": "Enjoy tasty discounts.",
    "emoji": "🍔",
    "benefits": [
      {
        "title": "Free Coffee at Campus Café",
        "description": "Get a free coffee with any sandwich purchase.",
        "url": "https://example.com/free-coffee",
        "favicon_url": "https://example.com/icons/cafe.ico",
        "image_url": "https://picsum.photos/200/300",
        "aliases": ["coffee", "cafe", "beverages"]
      },
      {
        "title": "10% off at Pizza Palace",
        "description": "Show your student card to get a discount on all orders.",
        "url": "https://example.com/pizza-discount",
        "favicon_url": "https://example.com/icons/pizza.ico",
        "image_url": "https://picsum.photos/200/300",
        "aliases": ["pizza", "italian", "food"]
      }
    ]
  },
  {
    "title": "Culture & Entertainment",
    "description": "Discover discounted access.",
    "emoji": "🎉",
    "benefits": [
      {
        "title": "Museum Entry for €1",
        "description": "Visit the City Museum for just €1 with your student ID.",
        "url": "https://example.com/museum-deal",
        "favicon_url": "https://example.com/icons/museum.ico",
        "image_url": "https://picsum.photos/200/300",
        "aliases": ["museum", "art", "history"]
      }
    ]
  },
  {
    "title": "Shopping & Services",
    "description": null,
    "emoji": "🛍️",
    "benefits": [
      {
        "title": "10% Off at Student Tech Store",
        "description": "Discount on all electronics and accessories.",
        "url": "https://example.com/tech-discount",
        "favicon_url": null,
        "image_url":
            "https://www.mvg.de/dam/jcr:86494fae-6133-41bc-ac01-ac8e4ab95c10/19268-MVG-29E-Ticket-Student-Headerbild-Landingpage-1920x1080_E01.jpg",
        "aliases": ["tech", "electronics", "gadgets"]
      }
    ]
  },
  {
    "title": "Health & Fitness",
    "description": null,
    "emoji": "🏋️‍♂️",
    "benefits": [
      {
        "title": "Free Gym Trial",
        "description": "Get a free week at the campus gym.",
        "url": "https://example.com/gym-trial",
        "favicon_url": null,
        "image_url": null,
        "aliases": ["gym", "fitness", "health"]
      }
    ]
  }
];
