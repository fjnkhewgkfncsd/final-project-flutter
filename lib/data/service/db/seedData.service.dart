import 'package:sqflite/sqflite.dart';
class SeedData {

  Future<void> seedInitialData(Database database) async {
    final db = database;
    final emergencyId = await db.insert('emergency', {
      'emergencyName': 'Fire',
      'emergencyImage': 'fire_image.png',
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
      List<int> emergencyActionIds = [];
      final List<Map<String, dynamic>> emergencyActions = 
      [
        {
          'actionTitle': 'Basement Fire Risk',
          'actionDescription':
              'Basements fill with smoke quickly. Stay low, block smoke with cloth, and signal for help immediately. Call emergency services if possible.',
          'LevelOfDanger': 'High',
        },
        {
          'actionTitle': 'Injured and Cannot Move',
          'actionDescription':
              'Do not attempt to move if it is unsafe. Stay low, protect your airway from smoke, and call emergency services. Signal your location if possible.',
          'LevelOfDanger': 'High',
        },
        {
          'actionTitle': 'Others Need Assistance',
          'actionDescription':
              'If safe, assist others to move together. If not safe, call emergency services immediately and report their location.',
          'LevelOfDanger': 'Medium',
        },
        {
          'actionTitle': 'Exit Safely',
          'actionDescription':
              'Leave the building immediately using the stairs. Move to a safe open area away from the building and wait for help.',
          'LevelOfDanger': 'Low',
        },
        {
          'actionTitle': 'Signal from Window or Balcony',
          'actionDescription':
              'Go to the window or balcony, close doors behind you, block smoke, and signal for help. Do not jump unless instructed by rescuers.',
          'LevelOfDanger': 'High',
        },
        {
          'actionTitle': 'No Safe Escape',
          'actionDescription':
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
  }
}