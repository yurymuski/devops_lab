import configparser
import datetime
import json
import psutil
import schedule

clearjson = open("log.json", "w")
clearjson.close()
cleartxt = open("log.txt", "w")
cleartxt.close()

snapshot = 1

config = configparser.ConfigParser()
config.read('conf.ini')
output_type = config.get('common', 'type')
interval = config.get('common', 'interval')


def txt():
    global snapshot
    f = open('log.txt', "a")
    time = datetime.datetime.strftime(datetime.datetime.now(), '%Y-%m-%d-%H:%M:%S')
    f.write("Snapshot{0}:{1}\n".format(snapshot, time))
    f.write('Overall CPU load:{}%\n'.format(psutil.cpu_percent(interval=1, percpu=True)))
    f.write('Overall memory usage: Total:{}MB\n'.format((psutil.disk_usage('/')[0] / 1024 / 1024).__round__(2)))
    f.write('Overall memory usage: Percent free:{}%\n'.format(psutil.disk_usage('/')[3]))
    f.write('Overall virtual memory usage: Percent free:{}%\n'.format(psutil.virtual_memory()[2]))
    f.write('Disk IO information: read: {}MB\n'.format((psutil.disk_io_counters()[2] / 1024 / 1024).__round__(2)))
    f.write('Disk IO information: write:{}MB\n'.format((psutil.disk_io_counters()[3] / 1024 / 1024).__round__(2)))
    f.write('Network information: sent:{}MB\n'.format((psutil.net_io_counters()[0] / 1024 / 1024).__round__(2)))
    f.write('Network information: recv:{}MB\n'.format((psutil.net_io_counters()[1] / 1024 / 1024).__round__(2)))
    f.write("\n")
    f.close()
    snapshot += 1


def json1():
    global snapshot
    time = datetime.datetime.strftime(datetime.datetime.now(), '%Y-%m-%d-%H:%M:%S')

    snapshotdict = {
        'Overall CPU load:': psutil.cpu_percent(interval=1, percpu=True),
        'Overall memory usage: Total:': str((psutil.disk_usage('/')[0] / 1024 / 1024).__round__(2)) + "MB",
        'Overall memory usage: Percent free:': str(psutil.disk_usage('/')[3]) + "%",
        'Overall virtual memory usage: Percent free:': str(psutil.virtual_memory()[2]) + "%",
        'Disk IO information: read:': str((psutil.disk_io_counters()[2] / 1024 / 1024).__round__(2)) + "MB",
        'Disk IO information: write:': str((psutil.disk_io_counters()[3] / 1024 / 1024).__round__(2)) + "MB",
        'Network information: sent:': str((psutil.net_io_counters()[0] / 1024 / 1024).__round__(2)) + "MB",
        'Network information: recv:': str((psutil.net_io_counters()[1] / 1024 / 1024).__round__(2)) + "MB"
    }

    data = ('SNAPSHOT' + str(snapshot) + ": " + str(time) + ": ", snapshotdict)
    with open("log.json", "a") as f:
        json.dump(data, f, indent=3, sort_keys=True)
        f.close()
        snapshot += 1


if output_type == "txt":
    schedule.every(int(interval)).seconds.do(txt)
elif output_type == "json":
    schedule.every(int(interval)).seconds.do(json1)

while True:
    schedule.run_pending()
