list_key = ['one', 'two', 'three', 'four', 'five']
list_val = [1, 2, 3, 4]


def create_dict(list_key, list_val):
    if len(list_key) > len(list_val):
        while len(list_key) > len(list_val):
            list_val.append(None)
    else:
        list_val = list_val[0:len(list_key)]
    return {key: value for key, value in zip(list_key, list_val)}


print(create_dict(list_key, list_val))
