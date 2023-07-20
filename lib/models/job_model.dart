class JobModel {
  List? jobCategory, jobType, careerLevel, jobExperience, jobQualification;
  String? companyLogo,
      resumeCategory,
      resumeTitle,
      resumeEducationLevel,
      resumeExperience,
      content,
      title,
      language,
      postedDate,
      companyName,
      resumeRate,
      resumeImage,
      minSalary,
      maxSalary,
      minRate,
      maxRate,
      resumeEmail,
      location,
      companyID,
      sinceCompany,
      companyEmail,
      companyCategory,
      companyTeamSize,
      companyImage,
      link;
  int? id, featured, jobPosted;
  double? lat, long;
  JobModel(
      {this.id,
      this.title,
      this.resumeEducationLevel,
      this.language,
      this.resumeTitle,
      this.companyID,
      this.companyName,
      this.companyLogo,
      this.companyTeamSize,
      this.jobPosted,
      this.location,
      this.sinceCompany,
      this.resumeRate,
      this.resumeImage,
      this.resumeEmail,
      this.resumeExperience,
      this.minRate,
      this.maxRate,
      this.minSalary,
      this.maxSalary,
      this.jobCategory,
      this.companyCategory,
      this.resumeCategory,
      this.featured,
      this.content,
      this.postedDate,
      this.jobExperience,
      this.careerLevel,
      this.jobType,
      this.companyEmail,
      this.lat,
      this.long,
      this.companyImage,
      this.jobQualification,
      this.link});

  static JobModel? fromMap(Map<String, dynamic> map) {
    // ignore: unnecessary_null_comparison
    if (map == null) return null;
    String? companyImage,
        companyCategory,
        companyTeamSize,
        resumeCategory,
        resumeExperience,
        resumeEducationLevel;
    List categories = [],
        types = [],
        career = [],
        experience = [],
        qualification = [];

    if (map.containsKey('_embedded')) {
      if (map['_embedded'].containsKey('wp:term')) {
        for (List data in map['_embedded']['wp:term']) {
          if (data.isNotEmpty) {
            if (data.first['taxonomy'] == 'job_listing_category') {
              categories = data;
            } else if (data.first['taxonomy'] == 'job_listing_type') {
              types = data;
            } else if (data.first['taxonomy'] == 'job_listing_career_level') {
              career = data;
            } else if (data.first['taxonomy'] == 'job_listing_experience') {
              experience = data;
            } else if (data.first['taxonomy'] == 'job_listing_qualification') {
              qualification = data;
            }

            for (var d in data) {
              if (d['taxonomy'] == 'resume_category') {
                resumeCategory = d['name'] ?? '';
              }
              if (d['taxonomy'] == 'company_category') {
                companyCategory = d['name'] ?? '';
              }
              if (d['taxonomy'] == 'company_team_size') {
                companyTeamSize = d['name'] ?? '';
              }
              if (d['taxonomy'] == 'resume_education_level') {
                resumeEducationLevel = d['name'] ?? '';
              }
              if (d['taxonomy'] == 'resume_experience') {
                resumeExperience = d['name'] ?? '';
              }
            }
          }
        }
      }

      if (map['_embedded'].containsKey("wp:featuredmedia")) {
        for (var data in map['_embedded']['wp:featuredmedia']) {
          if (data.isNotEmpty) {
            if (data['type'] == 'attachment') {
              companyImage = data['source_url'];
            }
          }
        }
      }
    }
    return JobModel(
        id: map['id'],
        title: map['title']['rendered'] ?? '',
        companyName: map['company_manager_name'] ?? '',
        companyEmail: map['meta']['_company_email'] ?? '',
        companyImage: companyImage ?? '',
        companyCategory: companyCategory ?? '',
        resumeCategory: resumeCategory ?? '',
        language: map['meta']['_languages'] ?? '',
        companyTeamSize: companyTeamSize ?? '',
        sinceCompany: map['meta']['_company_since'] ?? '',
        jobPosted:
            map['posted_jobs'].runtimeType == String ? 0 : map['posted_jobs'],
        companyID: map['meta']['_company_manager_id'] ?? '',
        companyLogo: map['company_manager_logo'] ?? '',
        location: map['meta']['geolocation_formatted_address'] ?? '',
        minRate: map['meta']['_rate_min'] ?? '',
        maxRate: map['meta']['_rate_max'] ?? '',
        resumeImage: map['meta']['_candidate_photo'] ?? '',
        resumeTitle: map['meta']['_candidate_title'] ?? '',
        resumeEmail: map['meta']['_candidate_email'] ?? '',
        resumeExperience: resumeExperience ?? '',
        resumeEducationLevel: resumeEducationLevel ?? '',
        resumeRate:
            map['meta']['_rate'] != null ? map['meta']['_rate'].toString() : '',
        minSalary: map['meta']['_salary_min'] ?? '',
        maxSalary: map['meta']['_salary_max'] ?? '',
        lat: map['meta']['geolocation_lat'] != ''
            ? double.parse(map['meta']['geolocation_lat'])
            : null,
        long: map['meta']['geolocation_long'] != ''
            ? double.parse(map['meta']['geolocation_long'])
            : null,
        featured: map['meta']['_featured'],
        jobCategory: categories,
        content: map['content']['rendered'],
        postedDate: map['date'],
        jobType: types,
        careerLevel: career,
        jobExperience: experience,
        jobQualification: qualification,
        link: map['link'] ?? '');
  }
}
