function numberOnly(i) {
    if (i.value.length > 0) {
        i.value = i.value.replace(/[^\d]+/g, '');
    }
}