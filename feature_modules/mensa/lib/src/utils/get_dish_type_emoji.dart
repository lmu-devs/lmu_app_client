String getDishTypeEmoji(String dishType) {
  switch (dishType) {
    case "Pasta":
      return '🍝';
    case "Pizza":
      return '🍕';
    case "Studitopf":
      return '🍲';
    case "Fleisch":
      return '🥩';
    case "Fisch":
      return '🐟';
    case "Beilagen":
      return '🥕';
    case "Grill":
      return '🍖';
    case "Süßspeise":
      return '🍰';
    default:
      return '🍽️';
  }
}
