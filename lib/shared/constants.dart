import 'package:flutter/material.dart';

class AppConstants {
  // Personal Information
  static const String name = '';
  static const String title =
      'Senior Flutter Developer & Cloud Solutions Architect';
  static const String location = 'Oregon, USA';
  static const String email = 'stringnamematt@gmail.com';
  static const String phone = '+1 (503) 951-5464';

  // Hero Section
  static const String heroTitle = 'Matt Smith';
  static const String heroSubtitle =
      'Flutter Developer & Cloud Solutions Architect';
  static const String heroDescription =
      'Building innovative mobile and web applications with Flutter & Firebase. '
      'Specializing in full-stack development, cloud architecture, and AI integration.';

  // About Me

  static const String aboutTitle = 'About Me';
  static const String aboutDescription =
      'Results-driven developer with a passion for creating seamless, high-performance '
      'applications. I specialize in Flutter development, Firebase backend solutions, '
      'and integrating cutting-edge AI technologies. With experience managing complex '
      'projects from concept to deployment, I bring both technical expertise and '
      'strategic thinking to every challenge.';

  // Social Links
  static const String githubUrl = 'https://github.com/string-name-matt';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/matthew-smith-dev/';
  static const String websiteUrl = 'https://matt-smith-dev.com';

  // Skills Categories
  static const Map<String, List<SkillItem>> skills = {
    'Frontend': [
      SkillItem(
          name: 'Flutter',
          level: 0.95,
          icon: 'assets/images/logos/flutter_logo.png'),
      SkillItem(
          name: 'Dart', level: 0.95, icon: 'assets/images/logos/dart_logo.png'),
      SkillItem(
          name: 'Riverpod',
          level: 0.90,
          icon: 'assets/images/logos/riverpod_logo.png'),
      SkillItem(
          name: 'Material Design',
          level: 0.90,
          icon: 'assets/images/logos/flutter_logo.png'),
      SkillItem(
          name: 'Responsive UI',
          level: 0.85,
          icon: 'assets/images/logos/flutter_logo.png'),
    ],
    'Backend & Cloud': [
      SkillItem(
          name: 'Firebase',
          level: 0.95,
          icon: 'assets/images/logos/firebase_logo.png'),
      SkillItem(
          name: 'Cloud Functions',
          level: 0.90,
          icon: 'assets/images/logos/cloud_functions_logo.png'),
      SkillItem(
          name: 'Node.js',
          level: 0.85,
          icon: 'assets/images/logos/node_logo.png'),
      SkillItem(
          name: 'Firestore',
          level: 0.95,
          icon: 'assets/images/logos/firestore_logo.png'),
      SkillItem(
          name: 'REST APIs',
          level: 0.90,
          icon: 'assets/images/logos/rest_logo.png'),
    ],
    'AI & Integration': [
      SkillItem(
          name: 'OpenAI API',
          level: 0.85,
          icon: 'assets/images/logos/openai_logo.png'),
      SkillItem(
          name: 'Google Gemini',
          level: 0.80,
          icon: 'assets/images/logos/gemini_logo.png'),
      SkillItem(
          name: 'Stripe',
          level: 0.85,
          icon: 'assets/images/logos/flutter_logo.png'),
      SkillItem(
          name: 'Twilio',
          level: 0.80,
          icon: 'assets/images/logos/twilio_logo.png'),
      SkillItem(
          name: 'SFTP',
          level: 0.75,
          icon: 'assets/images/logos/firebase_logo.png'),
    ],
    'Tools & Platforms': [
      SkillItem(
          name: 'Git', level: 0.90, icon: 'assets/images/logos/git_logo.png'),
      SkillItem(
          name: 'GCP',
          level: 0.85,
          icon: 'assets/images/logos/google_cloud_logo.png'),
      SkillItem(
          name: 'VS Code',
          level: 0.95,
          icon: 'assets/images/logos/vscode_logo.png'),
      SkillItem(
          name: 'CI/CD',
          level: 0.80,
          icon: 'assets/images/logos/firebase_logo.png'),
      SkillItem(
          name: 'Agile',
          level: 0.85,
          icon: 'assets/images/logos/flutter_logo.png'),
    ],
  };

  // Projects
  static const List<ProjectItem> projects = [
    ProjectItem(
      id: 'courthouse-connect',
      title: 'Courthouse Connect',
      shortDescription:
          'Enterprise internal communication platform serving 200+ courthouse staff',
      fullDescription:
          'A comprehensive internal employee application serving a courthouse with 200+ staff members. '
          'Features include AI-powered chatbot assistance using OpenAI and Google Gemini, real-time maintenance tracking, '
          'news distribution, employee directory with search, class scheduling and registration, digital form management, '
          'and staff engagement features like an NFL pool. Built with Flutter and Firebase, implementing robust state '
          'management with Riverpod and real-time synchronization across multiple modules. The app serves as a central '
          'hub for all courthouse communication and operational needs.',
      technologies: [
        'Flutter',
        'Firebase',
        'OpenAI API',
        'Google Gemini',
        'Firestore',
        'Cloud Functions',
        'Riverpod',
        'Real-time Sync',
        'Firebase Auth',
        'Push Notifications'
      ],
      features: [
        'AI Chatbot with dual AI integration (OpenAI & Gemini)',
        'Real-time maintenance board with status tracking',
        'News & announcements distribution system',
        'Employee directory with advanced search',
        'Class scheduling and registration management',
        'Digital form creation and management system',
        'Staff engagement features (NFL Pool, social)',
        'Push notifications for important updates',
        'Admin dashboard for content management',
        'Multi-module navigation architecture',
        'Role-based access control',
        'Analytics and usage tracking',
      ],
      imageUrl: 'assets/images/projects/courthouse_hero.png',
      thumbnailUrl: 'assets/images/projects/courthouse_thumb.png',
      demoUrl: '',
      githubUrl: '',
      category: 'Enterprise',
      featured: true,
      status: 'Live in Production',
    ),
    ProjectItem(
      id: 'healthpass',
      title: 'HealthPass',
      shortDescription:
          'Comprehensive health insurance platform with automated workflows serving 1,800+ members',
      fullDescription:
          'A full-stack health insurance management platform serving 1,800+ active members with complex healthcare workflows. '
          'Built a sophisticated data pipeline integrating SFTP file transfers for automated enrollment processing, '
          'Stripe payment orchestration for membership dues, and Twilio SMS notifications for member communications. '
          'Implemented 15+ Node.js Cloud Functions for automated enrollment processing, continuous patient syncing, '
          'DPC provider selection workflows, membership review queues, and automated reporting (AAPTIV, HINT, effective reports). '
          'Features privacy-first design with granular access controls meeting healthcare compliance standards, '
          'real-time member dashboards showing health access status, and seamless integration with healthcare provider systems. '
          'The platform handles all aspects of health insurance membership from enrollment to ongoing management.',
      technologies: [
        'Flutter',
        'Firebase',
        'Node.js Cloud Functions',
        'Stripe API',
        'Twilio API',
        'SFTP/FTP',
        'Firestore',
        'Google Sheets API',
        'Dart Services',
        'Firebase Auth',
        'Riverpod State Management',
      ],
      features: [
        'Automated SFTP data pipeline for member enrollment',
        'Stripe payment integration with subscription management',
        'SMS notifications via Twilio (appointments, updates, reminders)',
        '15+ Cloud Functions for workflow automation',
        'DPC provider selection and assignment workflow',
        'Member review queue with approval system',
        'Real-time member dashboard with health access status',
        'Automated reporting (AAPTIV, HINT, effective reports)',
        'Privacy controls and HIPAA compliance features',
        'Admin panel for membership management',
        'Continuous patient syncing across provider systems',
        'ABC member import and processing workflows',
        'Duplicate detection and resolution system',
        'Health access member normalization',
        'Generate reports with Google Sheets integration',
      ],
      imageUrl: 'assets/images/projects/healthpass_hero.png',
      thumbnailUrl: 'assets/images/projects/healthpass_thumb.png',
      demoUrl: '',
      githubUrl: '',
      category: 'Full-Stack',
      featured: true,
      status: 'Live in Production',
    ),
    // ProjectItem(
    //   id: 'project-3',
    //   title: 'Your Next Project',
    //   shortDescription: 'Add your project description here',
    //   fullDescription: 'This is a placeholder for your next amazing project!',
    //   technologies: ['Flutter', 'Firebase'],
    //   features: [
    //     'Feature 1',
    //     'Feature 2',
    //     'Feature 3',
    //   ],
    //   imageUrl: 'assets/images/projects/placeholder.png',
    //   // PLACEHOLDER
    //   thumbnailUrl: 'assets/images/projects/placeholder_thumb.png',
    //   // PLACEHOLDER
    //   demoUrl: '',
    //   githubUrl: '',
    //   category: 'Mobile',
    //   featured: false,
    //   status: 'In Development',
    // ),
  ];

  // Project Categories
  static const List<String> projectCategories = [
    'All',
    'Full-Stack',
    'Enterprise',
    'Mobile',
    'Web',
    'AI/ML',
  ];

  // Tech Stack Deep Dive
  static const Map<String, TechStackItem> techStackDetails = {
    'Frontend Development': TechStackItem(
      title: 'Modern Mobile & Web Development',
      description:
          'Building responsive, performant cross-platform applications with modern frameworks',
      technologies: [
        'Flutter & Dart - 3+ years production experience',
        'Material Design 3 & Cupertino iOS design',
        'Riverpod State Management',
        'GoRouter Navigation',
        'Responsive Design Patterns (Mobile, Tablet, Desktop)',
        'Custom Animations & Transitions',
        'Widget Architecture & Composition',
      ],
    ),
    'Backend & Cloud': TechStackItem(
      title: 'Cloud Architecture & Serverless',
      description:
          'Scalable, secure backend systems with Firebase and Google Cloud Platform',
      technologies: [
        'Firebase (Auth, Firestore, Functions, Storage, Hosting)',
        'Node.js Cloud Functions (15+ production functions)',
        'RESTful API Design & Integration',
        'Real-time Database Synchronization',
        'SFTP/FTP File Transfer Automation',
        'Google Cloud Platform (GCP)',
        'Database Schema Design & Optimization',
      ],
    ),
    'Integrations & APIs': TechStackItem(
      title: 'Third-Party Services & APIs',
      description:
          'Seamless integration with payment, communication, and AI services',
      technologies: [
        'Stripe Payment Processing & Subscriptions',
        'Twilio SMS & Communications',
        'OpenAI GPT-3.5/4 API Integration',
        'Google Gemini AI Integration',
        'Google Sheets API for Reporting',
        'Custom API Integration',
        'OAuth & Authentication Flows',
      ],
    ),
    'DevOps & Tools': TechStackItem(
      title: 'Development & Deployment',
      description: 'Modern development workflow and deployment practices',
      technologies: [
        'Git Version Control & GitHub',
        'CI/CD with Firebase Hosting',
        'VS Code with Flutter Extensions',
        'Firebase CLI & FlutterFire',
        'Agile Development Methodology',
        'Code Review & Testing Practices',
        'App Store & Play Store Deployment',
      ],
    ),
  };

  // Impact Metrics
  static const List<ImpactMetric> impactMetrics = [
    ImpactMetric(
      icon: Icons.people_outline,
      value: '2,000+',
      label: 'Active Users',
      description: 'Across production applications',
    ),
    ImpactMetric(
      icon: Icons.functions,
      value: '15+',
      label: 'Cloud Functions',
      description: 'Automated workflows deployed',
    ),
    ImpactMetric(
      icon: Icons.apps,
      value: '2',
      label: 'Major Projects',
      description: 'Live in production environments',
    ),
    ImpactMetric(
      icon: Icons.security_outlined,
      value: '100%',
      label: 'Compliant',
      description: 'HIPAA & privacy standards',
    ),
    ImpactMetric(
      icon: Icons.speed_outlined,
      value: '<2s',
      label: 'Load Time',
      description: 'Average app initialization',
    ),
    ImpactMetric(
      icon: Icons.cloud_done_outlined,
      value: '99.9%',
      label: 'Uptime',
      description: 'Production reliability',
    ),
  ];

  // Services Offered
  static const List<ServiceOffering> services = [
    ServiceOffering(
      icon: Icons.phone_android,
      title: 'Mobile App Development',
      description:
          'Native iOS & Android applications built with Flutter for seamless cross-platform performance',
      deliverables: [
        'iOS & Android apps from single codebase',
        'Material Design & iOS Human Interface Guidelines',
        'App Store & Play Store deployment',
        'Responsive design for all screen sizes',
        'Ongoing maintenance & feature updates',
        'Performance optimization',
      ],
      startingPrice: 'Starting at \$15,000',
    ),
    ServiceOffering(
      icon: Icons.web,
      title: 'Web Application Development',
      description:
          'Responsive web applications with modern frameworks and cloud infrastructure',
      deliverables: [
        'Progressive Web Apps (PWA)',
        'Responsive design for all devices',
        'SEO optimization',
        'Firebase Hosting deployment',
        'Cross-browser compatibility',
        'Performance monitoring',
      ],
      startingPrice: 'Starting at \$10,000',
    ),
    ServiceOffering(
      icon: Icons.cloud_outlined,
      title: 'Firebase Backend Development',
      description:
          'Scalable, secure cloud infrastructure with automated workflows',
      deliverables: [
        'Firebase Authentication setup & customization',
        'Firestore database architecture & security rules',
        'Cloud Functions for automation & business logic',
        'Real-time data synchronization',
        'File storage & CDN setup',
        'Backup & disaster recovery',
      ],
      startingPrice: 'Starting at \$5,000',
    ),
    ServiceOffering(
      icon: Icons.integration_instructions,
      title: 'API Integration',
      description:
          'Connect your application to payment processors, AI services, and custom APIs',
      deliverables: [
        'Payment processing (Stripe, PayPal, etc.)',
        'SMS & email services (Twilio, SendGrid)',
        'AI integration (OpenAI, Google Gemini)',
        'Custom REST API development',
        'Third-party service integration',
        'Webhook setup & management',
      ],
      startingPrice: 'Starting at \$3,000',
    ),
    ServiceOffering(
      icon: Icons.support_agent,
      title: 'Consulting & Code Review',
      description: 'Expert guidance for your development project and team',
      deliverables: [
        'Architecture review & recommendations',
        'Code quality assessment',
        'Performance optimization strategies',
        'Security audit & best practices',
        'Team mentoring & training',
        'Technical documentation',
      ],
      startingPrice: '\$150/hour',
    ),
    ServiceOffering(
      icon: Icons.auto_fix_high,
      title: 'AI Integration Specialist',
      description: 'Add intelligent features to your application with AI APIs',
      deliverables: [
        'Chatbot implementation (OpenAI, Gemini)',
        'Natural language processing',
        'Content generation features',
        'AI-powered search & recommendations',
        'Custom AI model integration',
        'Prompt engineering & optimization',
      ],
      startingPrice: 'Starting at \$5,000',
    ),
  ];

  // Work Process
  static const List<ProcessStep> workProcess = [
    ProcessStep(
      number: 1,
      title: 'Discovery & Planning',
      description:
          'Deep dive into your business needs, target users, and project goals. Define scope, features, and success metrics.',
      duration: '1-2 weeks',
    ),
    ProcessStep(
      number: 2,
      title: 'Design & Architecture',
      description:
          'Create wireframes, UI mockups, and technical architecture. Design database schema and API structure.',
      duration: '1-2 weeks',
    ),
    ProcessStep(
      number: 3,
      title: 'Development',
      description:
          'Build your application with agile sprints. Weekly demos and regular updates to ensure alignment.',
      duration: '6-12 weeks',
    ),
    ProcessStep(
      number: 4,
      title: 'Testing & QA',
      description:
          'Comprehensive testing including unit tests, integration tests, and user acceptance testing.',
      duration: '1-2 weeks',
    ),
    ProcessStep(
      number: 5,
      title: 'Deployment & Launch',
      description:
          'Deploy to production environments. Submit to app stores. Set up monitoring and analytics.',
      duration: '1 week',
    ),
    ProcessStep(
      number: 6,
      title: 'Support & Iteration',
      description:
          'Ongoing maintenance, bug fixes, feature additions, and performance optimization.',
      duration: 'Ongoing',
    ),
  ];

  // Testimonials
  static const List<Testimonial> testimonials = [
    Testimonial(
      quote:
          'Matt built a complex health insurance platform that serves nearly 2,000 members. '
          'His expertise in automation and integration saved us countless hours of manual work.',
      author: 'HealthPass Client',
      role: 'CEO',
      project: 'HealthPass',
    ),
    Testimonial(
      quote:
          'The Courthouse Connect app has transformed how our 200+ employees communicate and collaborate. '
          'The AI chatbot alone has reduced our IT support tickets significantly.',
      author: 'Courthouse Client',
      role: 'IT Director',
      project: 'Courthouse Connect',
    ),
  ];

  // Blog Articles (planned topics)
  static const List<BlogArticle> blogArticles = [
    BlogArticle(
      id: 'building-healthcare-platform',
      title: 'Building a Healthcare Platform with Flutter & Firebase',
      summary:
          'Lessons learned from building a HIPAA-compliant platform serving 1,800+ members',
      readTime: '12 min read',
      publishDate: null,
      tags: ['Flutter', 'Firebase', 'Healthcare', 'HIPAA'],
      url: null,
    ),
    BlogArticle(
      id: 'ai-chatbots-enterprise',
      title: 'Integrating AI Chatbots in Enterprise Apps',
      summary:
          'A practical guide to implementing OpenAI and Google Gemini in production applications',
      readTime: '10 min read',
      publishDate: null,
      tags: ['AI', 'OpenAI', 'Gemini', 'Chatbots', 'Enterprise'],
      url: null,
    ),
    BlogArticle(
      id: 'cloud-functions-saas',
      title: '15 Cloud Functions Every SaaS Needs',
      summary:
          'Essential automation patterns for building scalable cloud applications',
      readTime: '8 min read',
      publishDate: null,
      tags: ['Cloud Functions', 'Firebase', 'Automation', 'SaaS'],
      url: null,
    ),
  ];

  // Technologies Currently Exploring
  static const List<String> exploringTech = [
    'Flutter Web Advanced Features',
    'Supabase as Firebase Alternative',
    'AI Agent Development',
    'Vector Databases for AI',
    'Advanced State Management Patterns',
    'Web3 & Blockchain Integration',
  ];

  // Call to Action
  static const String ctaTitle = 'Ready to Work Together?';
  static const String ctaDescription =
      'I\'m currently available for freelance projects and full-time opportunities. '
      'Let\'s build something amazing together!';

  // Resume Access Request
  static const String resumeAccessTitle = 'Request Resume Access';
  static const String resumeAccessDescription =
      'To view my full resume, please request access below. '
      'I\'ll review your request and grant access promptly.';
}

// Skill Item Model
class SkillItem {
  final String name;
  final double level; // 0.0 to 1.0
  final String icon;

  const SkillItem({
    required this.name,
    required this.level,
    required this.icon,
  });

  /// Returns a readable experience level based on the numeric level
  String get experienceLevel {
    if (level >= 0.95) return 'Expert';
    if (level >= 0.85) return 'Advanced';
    if (level >= 0.75) return 'Proficient';
    if (level >= 0.65) return 'Intermediate';
    return 'Familiar';
  }

  /// Returns a color for the experience level
  Color get levelColor {
    if (level >= 0.95) return const Color(0xFF10B981); // Green - Expert
    if (level >= 0.85) return const Color(0xFF2563EB); // Blue - Advanced
    if (level >= 0.75) return const Color(0xFF7C3AED); // Purple - Proficient
    if (level >= 0.65) return const Color(0xFFF59E0B); // Orange - Intermediate
    return const Color(0xFF94A3B8); // Gray - Familiar
  }
}

// Project Item Model
class ProjectItem {
  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final List<String> technologies;
  final List<String> features;
  final String imageUrl;
  final String thumbnailUrl;
  final String demoUrl;
  final String githubUrl;
  final String category;
  final bool featured;
  final String status;

  const ProjectItem({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.technologies,
    required this.features,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.demoUrl,
    required this.githubUrl,
    required this.category,
    required this.featured,
    required this.status,
  });
}

// Tech Stack Item Model
class TechStackItem {
  final String title;
  final String description;
  final List<String> technologies;

  const TechStackItem({
    required this.title,
    required this.description,
    required this.technologies,
  });
}

// Impact Metric Model
class ImpactMetric {
  final IconData icon;
  final String value;
  final String label;
  final String description;

  const ImpactMetric({
    required this.icon,
    required this.value,
    required this.label,
    required this.description,
  });
}

// Service Offering Model
class ServiceOffering {
  final IconData icon;
  final String title;
  final String description;
  final List<String> deliverables;
  final String startingPrice;

  const ServiceOffering({
    required this.icon,
    required this.title,
    required this.description,
    required this.deliverables,
    required this.startingPrice,
  });
}

// Process Step Model
class ProcessStep {
  final int number;
  final String title;
  final String description;
  final String duration;

  const ProcessStep({
    required this.number,
    required this.title,
    required this.description,
    required this.duration,
  });
}

// Testimonial Model
class Testimonial {
  final String quote;
  final String author;
  final String role;
  final String project;

  const Testimonial({
    required this.quote,
    required this.author,
    required this.role,
    required this.project,
  });
}

// Blog Article Model
class BlogArticle {
  final String id;
  final String title;
  final String summary;
  final String readTime;
  final DateTime? publishDate;
  final List<String> tags;
  final String? url;

  const BlogArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.readTime,
    this.publishDate,
    required this.tags,
    this.url,
  });
}
