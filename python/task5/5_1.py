import configparser
import datetime
import json
import psutil
import schedule

clearjson = open("log.json", "w")
clearjson.close()
cleartxt = open("log.txt", "w")
cleartxt.close()
clearlog = open("dec.log", "w")
clearlog.close()

config = configparser.ConfigParser()
config.read('conf.ini')
output_type = config.get('common', 'type')
interval = config.get('common', 'interval')
dec_enabled = config.getboolean('common', 'dec_enabled')





class DATA:
    snapshot = 1

    def __init__(self):
        self.Cpu = psutil.cpu_percent(interval=1, percpu=True)
        self.Mem_total = (psutil.disk_usage('/')[0] / 1024 / 1024).__round__(2)
        self.Mem_perc = psutil.disk_usage('/')[3]
        self.Virtmem_perc = psutil.virtual_memory()[2]
        self.Diskio_r = (psutil.disk_io_counters()[2] / 1024 / 1024).__round__(2)
        self.Diskio_w = (psutil.disk_io_counters()[3] / 1024 / 1024).__round__(2)
        self.Netio_s = (psutil.net_io_counters()[0] / 1024 / 1024).__round__(2)
        self.Netio_r = (psutil.net_io_counters()[1] / 1024 / 1024).__round__(2)
        self.time = datetime.datetime.strftime(datetime.datetime.now(), '%Y-%m-%d-%H:%M:%S')


def dec(func):
    def first(*args, **kwargs):
        f = open('dec.log', "a")
        #    print('Enter:', func.__name__, args, kwargs)
        f.write('Enter:{0}, {1}, {2}\n'.format(func.__name__, args, kwargs))
        f.write('snapshot:{}\n'.format(DATA.snapshot))
        func(*args, **kwargs)
        f.write('Exit:{}\n'.format(func.__name__))
        f.write("\n")
        f.close()

    return first if dec_enabled else func


class TXT(DATA):
    @dec
    def txt(self):
        f = open('log.txt', "a")
        f.write("Snapshot{0}:{1}\n".format(DATA.snapshot, self.time))
        f.write('Overall CPU load:{}%\n'.format(self.Cpu))
        f.write('Overall memory usage: Total:{}MB\n'.format(self.Mem_total))
        f.write('Overall memory usage: Percent free:{}%\n'.format(self.Mem_perc))
        f.write('Overall virtual memory usage: Percent free:{}%\n'.format(self.Virtmem_perc))
        f.write('Disk IO information: read: {}MB\n'.format(self.Diskio_r))
        f.write('Disk IO information: write:{}MB\n'.format(self.Diskio_w))
        f.write('Network information: sent:{}MB\n'.format(self.Netio_s))
        f.write('Network information: recv:{}MB\n'.format(self.Netio_r))
        f.write("\n")
        f.close()
        DATA.snapshot += 1


class JSON1(DATA):
    @dec
    def json1(self):
        self.time = datetime.datetime.strftime(datetime.datetime.now(), '%Y-%m-%d-%H:%M:%S')
        snapshotdict = {
            'Overall CPU load:': self.Cpu,
            'Overall memory usage: Total:': str(self.Mem_total) + "MB",
            'Overall memory usage: Percent free:': str(self.Mem_perc) + "%",
            'Overall virtual memory usage: Percent free:': str(self.Virtmem_perc) + "%",
            'Disk IO information: read:': str(self.Diskio_r) + "MB",
            'Disk IO information: write:': str(self.Diskio_w) + "MB",
            'Network information: sent:': str(self.Netio_s) + "MB",
            'Network information: recv:': str(self.Netio_r) + "MB"
        }

        data = ('SNAPSHOT' + str(DATA.snapshot) + ": " + str(self.time) + ": ", snapshotdict)
        with open("log.json", "a") as f:
            json.dump(data, f, indent=3, sort_keys=True)
            f.close()
            DATA.snapshot += 1


def run_txt():
    txt_obj = TXT()
    txt_obj.txt()


def run_jboss():
    json_obj = JSON1()
    json_obj.json1()


if output_type == "txt":
    schedule.every(int(interval)).seconds.do(run_txt)
elif output_type == "json":
    schedule.every(int(interval)).seconds.do(run_jboss)

while True:
    schedule.run_pending()
