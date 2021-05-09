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
                }, {...}
            ],
            'reports': {
                'heart': [
                    {'patient_id': 932003,
                     'time': 'datetime',
                     'stats': {}}, {...}
                ],
                'diabetes': [{
                    'patient_id': 392,
                    'time': 'datetime'

                }]

            }
        }, {...}
    ],
    'suggestions': {
        'heart': ['point 1', 'point 2', 'point 3'],
        'diabetes': ['point 1', 'point 2', 'point 3'],
    }
}
