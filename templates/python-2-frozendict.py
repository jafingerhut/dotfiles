

# https://pypi.org/project/frozendict/
#from frozendict import frozendict

# A frozendict can be created from a mutable dict by calling frozendict(d):

# >>> d1={1: 2, 3: 4, 5: 6}
# >>> fd1=frozendict(d1)
# >>> d1
# {1: 2, 3: 4, 5: 6}
# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>

# frozendict's appear to be compared to regular mutable dict's for
# "same set of keys, each mapped to same value", similar to Clojure
# maps:

# >>> d1==fd1
# True

# You can also create a frozendict using kwargs on frozendict, but I
# believe the kwargs are always converted to string values as keys:

# >>> fd2=frozendict(a=-1, b='foo', c=frozenset([1, 2]))
# >>> fd2
# <frozendict {'a': -1, 'c': frozenset([1, 2]), 'b': 'foo'}>
# >>> fd3=frozendict({'c': frozenset([2, 1]), 'b': ('fo' + 'o'), 'a': (3-4)})
# >>> fd3
# <frozendict {'a': -1, 'c': frozenset([1, 2]), 'b': 'foo'}>

# frozendict's appear to be compared via == to other frozendict's as
# they are to mutable dict's:

# >>> fd2==fd3
# True

# Operations for examining the contents of a dict appear to work
# similarly for a frozendict:

# >>> fd3['a']
# -1
# >>> fd3.keys()
# ['a', 'c', 'b']
# >>> for k in fd3:
# ...     print("%s -> %s" % (k, fd3[k]))
# ... 
# a -> -1
# c -> frozenset([1, 2])
# b -> foo


# You can delete a key from a mutable dict with 'del' operator, but
# not from frozendict:

# >>> d1
# {1: 2, 3: 4, 5: 6}
# >>> del d1[3]
# >>> d1
# {1: 2, 5: 6}

# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>
# >>> del fd1[3]
# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
# TypeError: 'frozendict' object doesn't support item deletion
# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>

# Similarly, you can change the value associated with a key in a
# mutable dict via assignment, but not for a frozendict:

# >>> d1
# {1: 2, 5: 6}
# >>> d1[5]=7
# >>> d1
# {1: 2, 5: 7}
# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>
# >>> fd1[5]=7
# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
# TypeError: 'frozendict' object does not support item assignment
# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>

# It also raises an exception even if you make an assignment to a key
# in a dict, even if the value you try to assign is the one already
# associated with that key.  That seems reasonable to always raise an
# exception on such an assignment, without checking whether the new
# and old associated values are the same.

# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>
# >>> fd1[3]=4
# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
# TypeError: 'frozendict' object does not support item assignment


# You can add a new key/value pair to a mutable dict, but not to a
# frozendict:

# >>> d1
# {1: 2, 5: 7}
# >>> d1[3]=4
# >>> d1
# {1: 2, 3: 4, 5: 7}
# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>
# >>> fd1[7]=8
# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
# TypeError: 'frozendict' object does not support item assignment
# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>

# You can "augment" a frozendict with the copy() method using kwargs.
# This does not change the original frozendict, but returns a new
# frozendict that is (in general) different than the original:

# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>
# >>> fd2=fd1.copy(c=-9, d=-16)
# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>
# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 5: 6, 'd': -16}>

# TBD: is there an operation like Clojure's merge or merge-with on
# frozendict's?

# If there is, it is not the copy() method:

# >>> fd1
# <frozendict {1: 2, 3: 4, 5: 6}>
# >>> fd3
# <frozendict {9: 10, 7: 8}>
# >>> fd1.copy(fd3)
# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
# TypeError: copy() takes exactly 1 argument (2 given)

# That seems to me a fairly odd error message for that failed call,
# though.  Why does it occur?  Maybe the copy() method takes **kwargs
# as a "single" argument?  But then how does fd3 get treated as "2
# given" argument?

# copy() can be used to replace the value associated with an existing
# key, as long as that key has type str:

# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 5: 6, 'd': -16}>
# >>> fd2b=fd2.copy(c=8)
# >>> fd2b
# <frozendict {1: 2, 'c': 8, 3: 4, 5: 6, 'd': -16}>


# TBD: I can create a frozendict with keys that are not of type str by
# starting with a mutable dict and calling frozendict() on it (see
# above).  It seems that if I want to use the copy() method to augment
# a frozendict, I can only add new keys with type str.  How can I
# write something like Clojure's assoc or dissoc that can have
# arbitrary types as keys (as well as arbitrary types for values)?

# Perhaps one way is to extract the mutable dict, make the desired
# changes to it, and make a new frozendict from that.  This is almost
# certainly not the most time-efficient way to do it, but I am looking
# for correct behavior right now, before efficiency.


# Because Python lets you dig into the implementation, we can bypass
# the 'immutable armor'.  The implementation of the open source
# frozendict library stores a normal Python mutable dict internally,
# and if you reach in and mutate that, then of course it changes the
# value of the 'immutable' frozendict.  Recommendation: So don't do
# that.

# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 5: 6, 'd': -16}>
# >>> fd2._dict
# {1: 2, 'c': -9, 3: 4, 5: 6, 'd': -16}
# >>> type(fd2._dict)
# <type 'dict'>
# >>> type(fd2)
# <class 'frozendict.frozendict'>
# >>> fd2._dict['e']=-25
# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}>


# Apparently you can pass a list of 2-tuples to the dict() function,
# and it will use them as key/value pairs:

# http://www.java2s.com/Code/Python/Dictionary/dictconstructorbuildsdictionariesdirectlyfromlistsofkeyvaluepairs.htm

# >>> d7=dict([((1, 2), 3), (4, (5, 6))])
# >>> d7
# {(1, 2): 3, 4: (5, 6)}
# >>> type(d7)
# <type 'dict'>
# >>> d7.keys()
# [(1, 2), 4]
# >>> map(type, d7.keys())
# [<type 'tuple'>, <type 'int'>]

# Maybe something like that can be passed as an argument to the
# frozendict copy() method?  The experiment below is not promising:

# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}>
# >>> fd3=fd2.copy([(5, 7)])
# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
# TypeError: copy() takes exactly 1 argument (2 given)

>>> fd2
<frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}>
>>> d3=fd2._dict.copy()
>>> d3
{1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}


def frozendict_assoc(fd, list_of_key_val_tuples):
    """Take a frozendict `fd`, and a list of 2-tuples of the form (key,
    value), and return a new frozendict that contains everything `fd`
    does, with all of the new (key, value) mappings from the list.

    If any of the keys in the list already have associated values in
    `fd`, the value will be replaced with the new one from the list.
    The list is used in the order given, so if the same key is given
    multiple times, only the last value will be kept.
    """
    assert isinstance(fd, frozendict)
    assert isinstance(list_of_key_val_tuples, list)
    mutable_dict = fd._dict.copy()
    for x in list_of_key_val_tuples:
        assert isinstance(x, tuple)
        assert len(x) == 2
        k = x[0]
        v = x[1]
        mutable_dict[k] = v
    return frozendict(mutable_dict)


def frozendict_dissoc(fd, list_of_keys):
    """Take a frozendict `fd`, and a list of keys, and return a new
    frozendict that contains everything `fd` does, except any keys in
    the list will no longer have a value associated with them in the
    returned frozendict.

    Raises an exception if any of the keys in the list do not have a
    value associated with them in `fd`.
    """
    assert isinstance(fd, frozendict)
    assert isinstance(list_of_keys, list)
    mutable_dict = fd._dict.copy()
    for k in list_of_keys:
        del mutable_dict[k]
    return frozendict(mutable_dict)


def frozendict_merge(fd, another_dict):
    """Take a frozendict `fd`, and another dictionary, which could be
    another frozendict, or a mutable Python dict.  Return a new
    frozendict that contains everything `fd` does, plus all of the
    key/value mappings of the other dictionary.

    If any of the keys in `another_dict` already have associated
    values in `fd`, the value will be replaced with the new one from
    `another_dict`.
    """
    assert isinstance(fd, frozendict)
    assert isinstance(another_dict, frozendict) or isinstance(another_dict, dict)
    mutable_dict = fd._dict.copy()
    for k in another_dict:
        mutable_dict[k] = another_dict[k]
    return frozendict(mutable_dict)


# Examples of using my frozendict functions:


# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}>
# >>> fd3=frozendict_assoc(fd2, [((5, 7), 3)])
# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}>
# >>> fd3
# <frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, (5, 7): 3, 'd': -16}>


# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}>
# >>> fd4=frozendict_dissoc(fd2, [1, 'e'])
# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}>
# >>> fd4
# <frozendict {'c': -9, 3: 4, 5: 6, 'd': -16}>


# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}>
# >>> fd5=frozendict_merge(fd2, {'c': 3, frozendict({'x': 24, (11, 13): (17, 19)}): -11})
# >>> fd2
# <frozendict {1: 2, 'c': -9, 3: 4, 'e': -25, 5: 6, 'd': -16}>
# >>> fd5
# <frozendict {1: 2, 'c': 3, 3: 4, 'e': -25, 5: 6, <frozendict {'x': 24, (11, 13): (17, 19)}>: -11, 'd': -16}>
# >>> fd2['c']
# -9
# >>> fd5['c']
# 3
# >>> fd5[frozendict({(11, 13): (17, 19), 'x': 24})]
# -11
