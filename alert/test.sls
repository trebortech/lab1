"Test alert for job demo":
  event.send:
    - name: 'salt/job/alert/{{ grains.get('id', '') }}'
