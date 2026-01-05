import 'package:sqflite/sqflite.dart';
class SeedData {

  Future<void> seedInitialData(Database database) async {
    final db = database;

    final categories = [
      'environmental',
      'injuries',
      'Breathing Emergencies',
      'Heart and Medical',
      'Poisoning',
      'Pediatric',
      'Other'
    ];

    final Map<String,int> categoryIds = {};

    for(final category in categories){
      final id = await db.insert('category',{
        "categoryName": category
      });
      categoryIds[category] = id;
    }
    final emergencyId = await db.insert('emergency', {
      'emergencyName': 'Fire',
      'emergencyIcon': 'local_fire_department',
      'categoryId' : categoryIds['environmental'],
    });
    final quizId = await db.insert('quiz',{
      'emergencyId': emergencyId,
    });
    List<int> questionIds = [];
    List<Map<String, dynamic>> questions = [
        {
          'quizId': quizId,
          'questionTitle': 'You are inside a building that is on fire. What floor are you currently on?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Is there heavy smoke in your current location?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Is the exit door near you blocked by fire or smoke?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Does the door feel hot when you touch it?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Is there a staircase available nearby?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Are you able to move without difficulty?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Are there other people with you who need help?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Can you safely reach a window or balcony?'
        }
      ];
      for(final question in questions){
        final questionId = await db.insert('question', question);
        questionIds.add(questionId);
      }
      await db.update('quiz', {
        'startQuestion': questionIds[0]},
        where: "quizId = ?",
        whereArgs: [quizId]
        );
      List<int> emergencyActionIds = [];
      final List<Map<String, dynamic>> emergencyActions = 
      [
        {
          'actionTitle': 'Basement Fire Risk',
          'instruction':
              'Basements fill with smoke quickly. Stay low, block smoke with cloth, and signal for help immediately. Call emergency services if possible.',
          'LevelOfDanger': 'High',
        },
        {
          'actionTitle': 'Injured and Cannot Move',
          'instruction':
              'Do not attempt to move if it is unsafe. Stay low, protect your airway from smoke, and call emergency services. Signal your location if possible.',
          'LevelOfDanger': 'High',
        },
        {
          'actionTitle': 'Others Need Assistance',
          'instruction':
              'If safe, assist others to move together. If not safe, call emergency services immediately and report their location.',
          'LevelOfDanger': 'Medium',
        },
        {
          'actionTitle': 'Exit Safely',
          'instruction':
              'Leave the building immediately using the stairs. Move to a safe open area away from the building and wait for help.',
          'LevelOfDanger': 'Low',
        },
        {
          'actionTitle': 'Signal from Window or Balcony',
          'instruction':
              'Go to the window or balcony, close doors behind you, block smoke, and signal for help. Do not jump unless instructed by rescuers.',
          'LevelOfDanger': 'High',
        },
        {
          'actionTitle': 'No Safe Escape',
          'instruction':
              'Stay in the safest room available. Seal doors with cloth to block smoke, stay low, and signal for help. Call emergency services immediately.',
          'LevelOfDanger': 'High',
        },
      ];
      for(final action in emergencyActions){
        final emergencyActionId = await db.insert('emergencyAction', action);
        emergencyActionIds.add(emergencyActionId);
      }
      final List<Map<String, dynamic>> answers = [

      // Question 1: What floor are you currently on?
      {
        'questionId': questionIds[0],
        'answerTitle': 'Ground floor',
        'nextQuestionId': questionIds[2],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[0],
        'answerTitle': 'Upper floor',
        'nextQuestionId': questionIds[7],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[0],
        'answerTitle': 'Basement',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[0],
      },

      // Question 2: Is there heavy smoke in your current location?
      {
        'questionId': questionIds[1],
        'answerTitle': 'Yes, thick smoke is present',
        'nextQuestionId': questionIds[3],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[1],
        'answerTitle': 'Some smoke but still visible',
        'nextQuestionId': questionIds[2],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[1],
        'answerTitle': 'No smoke at the moment',
        'nextQuestionId': questionIds[2],
        'emergencyActionId': null,
      },

      // Question 3: Is the exit door near you blocked?
      {
        'questionId': questionIds[2],
        'answerTitle': 'Yes, it is blocked',
        'nextQuestionId': questionIds[7],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[2],
        'answerTitle': 'Partially blocked',
        'nextQuestionId': questionIds[3],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[2],
        'answerTitle': 'No, it is clear',
        'nextQuestionId': questionIds[4],
        'emergencyActionId': null,
      },

      // Question 4: Does the door feel hot?
      {
        'questionId': questionIds[3],
        'answerTitle': 'Yes, it feels very hot',
        'nextQuestionId': questionIds[7],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[3],
        'answerTitle': 'Warm but not hot',
        'nextQuestionId': questionIds[4],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[3],
        'answerTitle': 'No, it feels normal',
        'nextQuestionId': questionIds[4],
        'emergencyActionId': null,
      },

      // Question 5: Is there a staircase available nearby?
      {
        'questionId': questionIds[4],
        'answerTitle': 'Yes, I can access the stairs',
        'nextQuestionId': questionIds[5],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[4],
        'answerTitle': 'No, stairs are not accessible',
        'nextQuestionId': questionIds[7],
        'emergencyActionId': null,
      },

      // Question 6: Are you able to move without difficulty?
      {
        'questionId': questionIds[5],
        'answerTitle': 'Yes, I can move normally',
        'nextQuestionId': questionIds[6],
        'emergencyActionId': null,
      },
      {
        'questionId': questionIds[5],
        'answerTitle': 'I am injured or weak',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[1],
      },

      // Question 7: Are there other people with you?
      {
        'questionId': questionIds[6],
        'answerTitle': 'Yes, there are others with me',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[2],
      },
      {
        'questionId': questionIds[6],
        'answerTitle': 'No, I am alone',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[3],
      },

      // Question 8: Can you reach a window or balcony?
      {
        'questionId': questionIds[7],
        'answerTitle': 'Yes, I can reach a window or balcony',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[4],
      },
      {
        'questionId': questionIds[7],
        'answerTitle': 'No, there is no safe access',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[5],
      },
    ];
    for(var answer in answers){
      await db.insert('answer', answer);
    }

    final burnEmergencyId = await db.insert('emergency', {
      'emergencyName': 'Burn Injury',
      'emergencyIcon': 'healing',
      'categoryId': categoryIds['injuries'],
    });

    final burnQuizId = await db.insert('quiz', {
      'emergencyId': burnEmergencyId,
    });

    List<int> burnQuestionIds = [];

    final burnQuestions = [
      {
        'quizId': burnQuizId,
        'questionTitle': 'What caused the burn?'
      },
      {
        'quizId': burnQuizId,
        'questionTitle': 'Is the burn area blistered or charred?'
      },
      {
        'quizId': burnQuizId,
        'questionTitle': 'How large is the burned area?'
      },
      {
        'quizId': burnQuizId,
        'questionTitle': 'Is the burn on the face, hands, or joints?'
      },
      {
        'quizId': burnQuizId,
        'questionTitle': 'Is the person conscious?'
      },
    ];

    for (final q in burnQuestions) {
      burnQuestionIds.add(await db.insert('question', q));
    }

    await db.update(
      'quiz',
      {'startQuestion': burnQuestionIds[0]},
      where: 'quizId = ?',
      whereArgs: [burnQuizId],
    );

    List<int> burnActionIds = [];

    final burnActions = [
      {
        'actionTitle': 'Minor Burn Care',
        'instruction':
            'Cool the burn under running water for 20 minutes. Do not apply ice or butter.',
        'LevelOfDanger': 'Low',
      },
      {
        'actionTitle': 'Serious Burn',
        'instruction':
            'Cover the burn with a clean cloth. Do not burst blisters. Seek medical help immediately.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Chemical Burn',
        'instruction':
            'Rinse the affected area with clean water for at least 20 minutes. Remove contaminated clothing.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Large Area Burn',
        'instruction':
            'Call emergency services immediately. Keep the person warm and still.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Unconscious Victim',
        'instruction':
            'Check breathing. Call emergency services immediately.',
        'LevelOfDanger': 'High',
      },
    ];

    for (final a in burnActions) {
      burnActionIds.add(await db.insert('emergencyAction', a));
    }
    final burnAnswers = [

      // Q1: Cause
      {
        'questionId': burnQuestionIds[0],
        'answerTitle': 'Hot liquid or steam',
        'nextQuestionId': burnQuestionIds[1],
        'emergencyActionId': null,
      },
      {
        'questionId': burnQuestionIds[0],
        'answerTitle': 'Chemical',
        'nextQuestionId': null,
        'emergencyActionId': burnActionIds[2],
      },

      // Q2: Blistered?
      {
        'questionId': burnQuestionIds[1],
        'answerTitle': 'Yes',
        'nextQuestionId': burnQuestionIds[2],
        'emergencyActionId': null,
      },
      {
        'questionId': burnQuestionIds[1],
        'answerTitle': 'No',
        'nextQuestionId': burnQuestionIds[2],
        'emergencyActionId': null,
      },

      // Q3: Size
      {
        'questionId': burnQuestionIds[2],
        'answerTitle': 'Small area',
        'nextQuestionId': burnQuestionIds[3],
        'emergencyActionId': null,
      },
      {
        'questionId': burnQuestionIds[2],
        'answerTitle': 'Large area',
        'nextQuestionId': null,
        'emergencyActionId': burnActionIds[3],
      },

      // Q4: Sensitive area
      {
        'questionId': burnQuestionIds[3],
        'answerTitle': 'Yes',
        'nextQuestionId': null,
        'emergencyActionId': burnActionIds[1],
      },
      {
        'questionId': burnQuestionIds[3],
        'answerTitle': 'No',
        'nextQuestionId': burnQuestionIds[4],
        'emergencyActionId': null,
      },

      // Q5: Conscious
      {
        'questionId': burnQuestionIds[4],
        'answerTitle': 'Yes',
        'nextQuestionId': null,
        'emergencyActionId': burnActionIds[0],
      },
      {
        'questionId': burnQuestionIds[4],
        'answerTitle': 'No',
        'nextQuestionId': null,
        'emergencyActionId': burnActionIds[4],
      },
    ];

    for (final ans in burnAnswers) {
      await db.insert('answer', ans);
    }

    final chokingEmergencyId = await db.insert('emergency', {
      'emergencyName': 'Choking',
      'emergencyIcon': 'air',
      'categoryId': categoryIds['Breathing Emergencies'],
    });

    final chokingQuizId = await db.insert('quiz', {
      'emergencyId': chokingEmergencyId,
    });
    List<int> chokingQuestionIds = [];

    final chokingQuestions = [
      {
        'quizId': chokingQuizId,
        'questionTitle': 'Is the person able to speak or cough?'
      },
      {
        'quizId': chokingQuizId,
        'questionTitle': 'Is the person breathing normally?'
      },
      {
        'quizId': chokingQuizId,
        'questionTitle': 'Is the person conscious?'
      },
      {
        'quizId': chokingQuizId,
        'questionTitle': 'Is the person a child or adult?'
      },
      {
        'quizId': chokingQuizId,
        'questionTitle': 'Has the object been expelled?'
      },
    ];

    for (final q in chokingQuestions) {
      chokingQuestionIds.add(await db.insert('question', q));
    }

    await db.update(
      'quiz',
      {'startQuestion': chokingQuestionIds[0]},
      where: 'quizId = ?',
      whereArgs: [chokingQuizId],
    );
    List<int> chokingActionIds = [];

    final chokingActions = [
      {
        'actionTitle': 'Encourage Coughing',
        'instruction':
            'Encourage the person to keep coughing. Do not interfere if they can breathe or speak.',
        'LevelOfDanger': 'Low',
      },
      {
        'actionTitle': 'Perform Abdominal Thrusts',
        'instruction':
            'Stand behind the person and perform abdominal thrusts (Heimlich maneuver) until the object is expelled.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Call Emergency Services',
        'instruction':
            'Call emergency services immediately and continue first aid if trained.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Child Choking Procedure',
        'instruction':
            'Use back blows and chest thrusts appropriate for children. Do not use adult force.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Unconscious Choking',
        'instruction':
            'Lay the person down, call emergency services, and begin CPR if trained.',
        'LevelOfDanger': 'High',
      },
    ];

    for (final a in chokingActions) {
      chokingActionIds.add(await db.insert('emergencyAction', a));
    }
    final chokingAnswers = [

      // Q1: Able to speak or cough?
      {
        'questionId': chokingQuestionIds[0],
        'answerTitle': 'Yes, they can cough or speak',
        'nextQuestionId': null,
        'emergencyActionId': chokingActionIds[0],
      },
      {
        'questionId': chokingQuestionIds[0],
        'answerTitle': 'No, they cannot speak',
        'nextQuestionId': chokingQuestionIds[1],
        'emergencyActionId': null,
      },

      // Q2: Breathing normally?
      {
        'questionId': chokingQuestionIds[1],
        'answerTitle': 'No, breathing is difficult',
        'nextQuestionId': chokingQuestionIds[2],
        'emergencyActionId': null,
      },
      {
        'questionId': chokingQuestionIds[1],
        'answerTitle': 'Yes, breathing is normal',
        'nextQuestionId': null,
        'emergencyActionId': chokingActionIds[0],
      },

      // Q3: Conscious?
      {
        'questionId': chokingQuestionIds[2],
        'answerTitle': 'Yes',
        'nextQuestionId': chokingQuestionIds[3],
        'emergencyActionId': null,
      },
      {
        'questionId': chokingQuestionIds[2],
        'answerTitle': 'No',
        'nextQuestionId': null,
        'emergencyActionId': chokingActionIds[4],
      },

      // Q4: Child or Adult?
      {
        'questionId': chokingQuestionIds[3],
        'answerTitle': 'Adult',
        'nextQuestionId': null,
        'emergencyActionId': chokingActionIds[1],
      },
      {
        'questionId': chokingQuestionIds[3],
        'answerTitle': 'Child',
        'nextQuestionId': null,
        'emergencyActionId': chokingActionIds[3],
      },

      // Q5: Object expelled? (fallback / safety end)
      {
        'questionId': chokingQuestionIds[4],
        'answerTitle': 'Yes',
        'nextQuestionId': null,
        'emergencyActionId': chokingActionIds[0],
      },
      {
        'questionId': chokingQuestionIds[4],
        'answerTitle': 'No',
        'nextQuestionId': null,
        'emergencyActionId': chokingActionIds[2],
      },
    ];

    for (final ans in chokingAnswers) {
      await db.insert('answer', ans);
    }
    final heartAttackEmergencyId = await db.insert('emergency', {
      'emergencyName': 'Heart Attack',
      'emergencyIcon': 'heart_broken',
      'categoryId': categoryIds['Heart and Medical'],
    });

    final heartAttackQuizId = await db.insert('quiz', {
      'emergencyId': heartAttackEmergencyId,
    });
    List<int> heartQuestionIds = [];

    final heartQuestions = [
      {
        'quizId': heartAttackQuizId,
        'questionTitle': 'Is the person experiencing chest pain or pressure?'
      },
      {
        'quizId': heartAttackQuizId,
        'questionTitle': 'Is the pain spreading to the arm, jaw, or back?'
      },
      {
        'quizId': heartAttackQuizId,
        'questionTitle': 'Is the person conscious?'
      },
      {
        'quizId': heartAttackQuizId,
        'questionTitle': 'Is the person breathing normally?'
      },
      {
        'quizId': heartAttackQuizId,
        'questionTitle': 'Has emergency medical help been contacted?'
      },
    ];

    for (final q in heartQuestions) {
      heartQuestionIds.add(await db.insert('question', q));
    }

    await db.update(
      'quiz',
      {'startQuestion': heartQuestionIds[0]},
      where: 'quizId = ?',
      whereArgs: [heartAttackQuizId],
    );
    List<int> heartActionIds = [];

    final heartActions = [
      {
        'actionTitle': 'Monitor and Rest',
        'instruction':
            'Have the person sit down and rest. Monitor their condition closely.',
        'LevelOfDanger': 'Medium',
      },
      {
        'actionTitle': 'Call Emergency Services',
        'instruction':
            'Call emergency services immediately. Do not delay medical assistance.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Give Aspirin',
        'instruction':
            'If not allergic, give aspirin to chew slowly while waiting for emergency services.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'CPR Required',
        'instruction':
            'Begin CPR immediately if the person becomes unresponsive and is not breathing.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Assist Breathing',
        'instruction':
            'Loosen tight clothing and ensure the airway is open while monitoring breathing.',
        'LevelOfDanger': 'High',
      },
    ];

    for (final a in heartActions) {
      heartActionIds.add(await db.insert('emergencyAction', a));
    }
    final heartAnswers = [

      // Q1: Chest pain?
      {
        'questionId': heartQuestionIds[0],
        'answerTitle': 'Yes, severe chest pain',
        'nextQuestionId': heartQuestionIds[1],
        'emergencyActionId': null,
      },
      {
        'questionId': heartQuestionIds[0],
        'answerTitle': 'No chest pain',
        'nextQuestionId': null,
        'emergencyActionId': heartActionIds[0],
      },

      // Q2: Pain spreading?
      {
        'questionId': heartQuestionIds[1],
        'answerTitle': 'Yes, pain spreads',
        'nextQuestionId': null,
        'emergencyActionId': heartActionIds[1],
      },
      {
        'questionId': heartQuestionIds[1],
        'answerTitle': 'No spreading pain',
        'nextQuestionId': heartQuestionIds[2],
        'emergencyActionId': null,
      },

      // Q3: Conscious?
      {
        'questionId': heartQuestionIds[2],
        'answerTitle': 'Yes, conscious',
        'nextQuestionId': heartQuestionIds[3],
        'emergencyActionId': null,
      },
      {
        'questionId': heartQuestionIds[2],
        'answerTitle': 'No, unconscious',
        'nextQuestionId': null,
        'emergencyActionId': heartActionIds[3],
      },

      // Q4: Breathing normally?
      {
        'questionId': heartQuestionIds[3],
        'answerTitle': 'Yes, breathing normally',
        'nextQuestionId': null,
        'emergencyActionId': heartActionIds[2],
      },
      {
        'questionId': heartQuestionIds[3],
        'answerTitle': 'No, difficulty breathing',
        'nextQuestionId': null,
        'emergencyActionId': heartActionIds[4],
      },

      // Q5: Emergency contacted?
      {
        'questionId': heartQuestionIds[4],
        'answerTitle': 'Yes',
        'nextQuestionId': null,
        'emergencyActionId': heartActionIds[0],
      },
      {
        'questionId': heartQuestionIds[4],
        'answerTitle': 'No',
        'nextQuestionId': null,
        'emergencyActionId': heartActionIds[1],
      },
    ];

    for (final ans in heartAnswers) {
      await db.insert('answer', ans);
    }
    final poisoningEmergencyId = await db.insert('emergency', {
      'emergencyName': 'Poisoning',
      'emergencyIcon': 'science',
      'categoryId': categoryIds['Poisoning'],
    });

    final poisoningQuizId = await db.insert('quiz', {
      'emergencyId': poisoningEmergencyId,
    });
    List<int> poisoningQuestionIds = [];

    final poisoningQuestions = [
      {
        'quizId': poisoningQuizId,
        'questionTitle': 'Is the person conscious?'
      },
      {
        'quizId': poisoningQuizId,
        'questionTitle': 'What type of poison was involved?'
      },
      {
        'quizId': poisoningQuizId,
        'questionTitle': 'Did the poisoning occur within the last hour?'
      },
      {
        'quizId': poisoningQuizId,
        'questionTitle': 'Is the person experiencing vomiting or seizures?'
      },
      {
        'quizId': poisoningQuizId,
        'questionTitle': 'Has poison control or emergency services been contacted?'
      },
    ];

    for (final q in poisoningQuestions) {
      poisoningQuestionIds.add(await db.insert('question', q));
    }

    await db.update(
      'quiz',
      {'startQuestion': poisoningQuestionIds[0]},
      where: 'quizId = ?',
      whereArgs: [poisoningQuizId],
    );
    List<int> poisoningActionIds = [];

    final poisoningActions = [
      {
        'actionTitle': 'Monitor Closely',
        'instruction':
            'Keep the person calm and monitor symptoms closely.',
        'LevelOfDanger': 'Medium',
      },
      {
        'actionTitle': 'Call Emergency Services',
        'instruction':
            'Call emergency services immediately. Time is critical in poisoning cases.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Do Not Induce Vomiting',
        'instruction':
            'Do not induce vomiting unless instructed by poison control.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Rinse Exposure Area',
        'instruction':
            'If poison is on skin or eyes, rinse with clean water for at least 15 minutes.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Provide Fresh Air',
        'instruction':
            'Move the person to fresh air immediately if poison was inhaled.',
        'LevelOfDanger': 'High',
      },
    ];

    for (final a in poisoningActions) {
      poisoningActionIds.add(await db.insert('emergencyAction', a));
    }

    final poisoningAnswers = [

      // Q1: Conscious?
      {
        'questionId': poisoningQuestionIds[0],
        'answerTitle': 'Yes, conscious',
        'nextQuestionId': poisoningQuestionIds[1],
        'emergencyActionId': null,
      },
      {
        'questionId': poisoningQuestionIds[0],
        'answerTitle': 'No, unconscious',
        'nextQuestionId': null,
        'emergencyActionId': poisoningActionIds[1],
      },

      // Q2: Type of poison?
      {
        'questionId': poisoningQuestionIds[1],
        'answerTitle': 'Swallowed chemical or medication',
        'nextQuestionId': poisoningQuestionIds[2],
        'emergencyActionId': null,
      },
      {
        'questionId': poisoningQuestionIds[1],
        'answerTitle': 'Inhaled gas or fumes',
        'nextQuestionId': null,
        'emergencyActionId': poisoningActionIds[4],
      },
      {
        'questionId': poisoningQuestionIds[1],
        'answerTitle': 'Skin or eye exposure',
        'nextQuestionId': null,
        'emergencyActionId': poisoningActionIds[3],
      },

      // Q3: Within last hour?
      {
        'questionId': poisoningQuestionIds[2],
        'answerTitle': 'Yes, within 1 hour',
        'nextQuestionId': poisoningQuestionIds[3],
        'emergencyActionId': null,
      },
      {
        'questionId': poisoningQuestionIds[2],
        'answerTitle': 'No, more than 1 hour ago',
        'nextQuestionId': null,
        'emergencyActionId': poisoningActionIds[0],
      },

      // Q4: Severe symptoms?
      {
        'questionId': poisoningQuestionIds[3],
        'answerTitle': 'Yes, vomiting or seizures',
        'nextQuestionId': null,
        'emergencyActionId': poisoningActionIds[1],
      },
      {
        'questionId': poisoningQuestionIds[3],
        'answerTitle': 'No severe symptoms',
        'nextQuestionId': null,
        'emergencyActionId': poisoningActionIds[2],
      },

      // Q5: Emergency contacted?
      {
        'questionId': poisoningQuestionIds[4],
        'answerTitle': 'Yes',
        'nextQuestionId': null,
        'emergencyActionId': poisoningActionIds[0],
      },
      {
        'questionId': poisoningQuestionIds[4],
        'answerTitle': 'No',
        'nextQuestionId': null,
        'emergencyActionId': poisoningActionIds[1],
      },
    ];

    for (final ans in poisoningAnswers) {
      await db.insert('answer', ans);
    }

    final electricShockEmergencyId = await db.insert('emergency', {
      'emergencyName': 'Electric Shock',
      'emergencyIcon': 'flash_on',
      'categoryId': categoryIds['Other'],
    });

    final electricShockQuizId = await db.insert('quiz', {
      'emergencyId': electricShockEmergencyId,
    });
    List<int> electricShockQuestionIds = [];

    final electricShockQuestions = [
      {
        'quizId': electricShockQuizId,
        'questionTitle': 'Is the person still in contact with the electrical source?'
      },
      {
        'quizId': electricShockQuizId,
        'questionTitle': 'Is the person conscious?'
      },
      {
        'quizId': electricShockQuizId,
        'questionTitle': 'Is there visible burn or injury?'
      },
      {
        'quizId': electricShockQuizId,
        'questionTitle': 'Did the shock come from a high-voltage source?'
      },
      {
        'quizId': electricShockQuizId,
        'questionTitle': 'Is the person having trouble breathing or chest pain?'
      },
    ];

    for (final q in electricShockQuestions) {
      electricShockQuestionIds.add(await db.insert('question', q));
    }

    await db.update(
      'quiz',
      {'startQuestion': electricShockQuestionIds[0]},
      where: 'quizId = ?',
      whereArgs: [electricShockQuizId],
    );
    List<int> electricShockActionIds = [];

    final electricShockActions = [
      {
        'actionTitle': 'Disconnect Power Safely',
        'instruction':
            'Turn off the power source immediately. Do not touch the person until power is disconnected.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Call Emergency Services',
        'instruction':
            'Call emergency services immediately. Electrical injuries can be life-threatening.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Check Breathing and Pulse',
        'instruction':
            'Check if the person is breathing and has a pulse. Begin CPR if trained and needed.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Treat Burns',
        'instruction':
            'Cool burns with clean running water. Do not apply creams or break blisters.',
        'LevelOfDanger': 'Medium',
      },
      {
        'actionTitle': 'Monitor and Keep Still',
        'instruction':
            'Keep the person still and monitor until medical help arrives.',
        'LevelOfDanger': 'Medium',
      },
    ];

    for (final a in electricShockActions) {
      electricShockActionIds.add(await db.insert('emergencyAction', a));
    }
    final electricShockAnswers = [

      // Q1: Still in contact?
      {
        'questionId': electricShockQuestionIds[0],
        'answerTitle': 'Yes, still touching power source',
        'nextQuestionId': null,
        'emergencyActionId': electricShockActionIds[0],
      },
      {
        'questionId': electricShockQuestionIds[0],
        'answerTitle': 'No, power is disconnected',
        'nextQuestionId': electricShockQuestionIds[1],
        'emergencyActionId': null,
      },

      // Q2: Conscious?
      {
        'questionId': electricShockQuestionIds[1],
        'answerTitle': 'Yes, conscious',
        'nextQuestionId': electricShockQuestionIds[2],
        'emergencyActionId': null,
      },
      {
        'questionId': electricShockQuestionIds[1],
        'answerTitle': 'No, unconscious',
        'nextQuestionId': null,
        'emergencyActionId': electricShockActionIds[1],
      },

      // Q3: Burns?
      {
        'questionId': electricShockQuestionIds[2],
        'answerTitle': 'Yes, burns are visible',
        'nextQuestionId': electricShockQuestionIds[4],
        'emergencyActionId': null,
      },
      {
        'questionId': electricShockQuestionIds[2],
        'answerTitle': 'No visible burns',
        'nextQuestionId': electricShockQuestionIds[4],
        'emergencyActionId': null,
      },

      // Q4: High voltage?
      {
        'questionId': electricShockQuestionIds[3],
        'answerTitle': 'Yes, high voltage',
        'nextQuestionId': null,
        'emergencyActionId': electricShockActionIds[1],
      },
      {
        'questionId': electricShockQuestionIds[3],
        'answerTitle': 'No, household electricity',
        'nextQuestionId': electricShockQuestionIds[4],
        'emergencyActionId': null,
      },

      // Q5: Breathing or chest pain?
      {
        'questionId': electricShockQuestionIds[4],
        'answerTitle': 'Yes',
        'nextQuestionId': null,
        'emergencyActionId': electricShockActionIds[2],
      },
      {
        'questionId': electricShockQuestionIds[4],
        'answerTitle': 'No',
        'nextQuestionId': null,
        'emergencyActionId': electricShockActionIds[4],
      },
    ];

    for (final ans in electricShockAnswers) {
      await db.insert('answer', ans);
    }
    final severeBleedingEmergencyId = await db.insert('emergency', {
      'emergencyName': 'Severe Bleeding',
      'emergencyIcon': 'bloodtype',
      'categoryId': categoryIds['injuries'],
    });

    final severeBleedingQuizId = await db.insert('quiz', {
      'emergencyId': severeBleedingEmergencyId,
    });
    List<int> severeBleedingQuestionIds = [];

    final severeBleedingQuestions = [
      {
        'quizId': severeBleedingQuizId,
        'questionTitle': 'Is the bleeding heavy and continuous?'
      },
      {
        'quizId': severeBleedingQuizId,
        'questionTitle': 'Is the wound on an arm or leg?'
      },
      {
        'quizId': severeBleedingQuizId,
        'questionTitle': 'Can direct pressure stop the bleeding?'
      },
      {
        'quizId': severeBleedingQuizId,
        'questionTitle': 'Is there an object embedded in the wound?'
      },
      {
        'quizId': severeBleedingQuizId,
        'questionTitle': 'Is the person showing signs of shock?'
      },
    ];

    for (final q in severeBleedingQuestions) {
      severeBleedingQuestionIds.add(await db.insert('question', q));
    }

    await db.update(
      'quiz',
      {'startQuestion': severeBleedingQuestionIds[0]},
      where: 'quizId = ?',
      whereArgs: [severeBleedingQuizId],
    );
    List<int> severeBleedingActionIds = [];

    final severeBleedingActions = [
      {
        'actionTitle': 'Apply Direct Pressure',
        'instruction':
            'Apply firm, direct pressure using a clean cloth or bandage. Do not remove soaked bandages.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Use Tourniquet',
        'instruction':
            'If bleeding is severe and on a limb, apply a tourniquet above the wound if trained.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Do Not Remove Embedded Object',
        'instruction':
            'Do not remove any object stuck in the wound. Apply pressure around it.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Treat for Shock',
        'instruction':
            'Lay the person down, keep them warm, and raise legs if possible. Call emergency services.',
        'LevelOfDanger': 'High',
      },
      {
        'actionTitle': 'Call Emergency Services',
        'instruction':
            'Call emergency services immediately. Severe bleeding can be life-threatening.',
        'LevelOfDanger': 'High',
      },
    ];

    for (final a in severeBleedingActions) {
      severeBleedingActionIds.add(await db.insert('emergencyAction', a));
    }
    final severeBleedingAnswers = [

      // Q1: Heavy bleeding?
      {
        'questionId': severeBleedingQuestionIds[0],
        'answerTitle': 'Yes, bleeding is heavy',
        'nextQuestionId': severeBleedingQuestionIds[1],
        'emergencyActionId': null,
      },
      {
        'questionId': severeBleedingQuestionIds[0],
        'answerTitle': 'No, bleeding is mild',
        'nextQuestionId': null,
        'emergencyActionId': severeBleedingActionIds[0],
      },

      // Q2: Arm or leg?
      {
        'questionId': severeBleedingQuestionIds[1],
        'answerTitle': 'Yes, arm or leg',
        'nextQuestionId': severeBleedingQuestionIds[2],
        'emergencyActionId': null,
      },
      {
        'questionId': severeBleedingQuestionIds[1],
        'answerTitle': 'No, body or head',
        'nextQuestionId': null,
        'emergencyActionId': severeBleedingActionIds[4],
      },

      // Q3: Pressure works?
      {
        'questionId': severeBleedingQuestionIds[2],
        'answerTitle': 'Yes, pressure slows bleeding',
        'nextQuestionId': null,
        'emergencyActionId': severeBleedingActionIds[0],
      },
      {
        'questionId': severeBleedingQuestionIds[2],
        'answerTitle': 'No, bleeding continues',
        'nextQuestionId': severeBleedingQuestionIds[3],
        'emergencyActionId': null,
      },

      // Q4: Object embedded?
      {
        'questionId': severeBleedingQuestionIds[3],
        'answerTitle': 'Yes, object is embedded',
        'nextQuestionId': null,
        'emergencyActionId': severeBleedingActionIds[2],
      },
      {
        'questionId': severeBleedingQuestionIds[3],
        'answerTitle': 'No embedded object',
        'nextQuestionId': null,
        'emergencyActionId': severeBleedingActionIds[1],
      },

      // Q5: Shock signs?
      {
        'questionId': severeBleedingQuestionIds[4],
        'answerTitle': 'Yes, signs of shock',
        'nextQuestionId': null,
        'emergencyActionId': severeBleedingActionIds[3],
      },
      {
        'questionId': severeBleedingQuestionIds[4],
        'answerTitle': 'No shock symptoms',
        'nextQuestionId': null,
        'emergencyActionId': severeBleedingActionIds[0],
      },
    ];

    for (final ans in severeBleedingAnswers) {
      await db.insert('answer', ans);
    }
  }
}