schema = {
    'user': [
        {
            'mail_id': 'string',
            'patient': [
                {
                    'name': 'string',
                    'mob': 9929929922,
                    'address': 'string',
                    'stats': {...},
                    'heart_reports': [{'probability': 89, 'created on': 'date'}, {...}],
                    'diabetes_reports': [{'probability': 79, 'created on': 'date'}, {...}]
                }, {...}
            ]
        }, {...}
    ],
    'suggestions': {
        'heart': ['point 1', 'point 2', 'point 3'],
        'diabetes': ['point 1', 'point 2', 'point 3'],
    }
}
