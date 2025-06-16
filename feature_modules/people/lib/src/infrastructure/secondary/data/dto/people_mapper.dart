import '../../../../domain/model/people.dart';
import '../../../../domain/model/people_category.dart';
import 'people_category_dto.dart';

class PeopleMapper {
  static List<PeopleCategory> mapToDomain(List<PeopleCategoryDto> dtos) {
    return dtos.map((categoryDto) {
      final peoples = categoryDto.people
          .map((peopleDto) => People(
                id: peopleDto.id,
                name: peopleDto.name,
                profileUrl: peopleDto.profileUrl,
                basicInfo: BasicInfo(
                  lastName: peopleDto.basicInfo.lastName,
                  gender: peopleDto.basicInfo.gender,
                  firstName: peopleDto.basicInfo.firstName,
                  officeHours: peopleDto.basicInfo.officeHours,
                  nameSuffix: peopleDto.basicInfo.nameSuffix,
                  employmentStatus: peopleDto.basicInfo.employmentStatus,
                  title: peopleDto.basicInfo.title,
                  note: peopleDto.basicInfo.note,
                  academicDegree: peopleDto.basicInfo.academicDegree,
                  status: peopleDto.basicInfo.status,
                ),
                faculty: peopleDto.faculty,
                roles: peopleDto.roles
                    .map((roleDto) => Role(
                          institution: roleDto.institution,
                          role: roleDto.role,
                          institutionUrl: roleDto.institutionUrl,
                        ))
                    .toList(),
                courses: peopleDto.courses,
              ))
          .toList();
      return PeopleCategory(
        name: categoryDto.name,
        description: '',
        emoji: '👥',
        peoples: peoples,
      );
    }).toList();
  }
}
