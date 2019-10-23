package me.xerosoft.pagedemo.services;

import me.xerosoft.pagedemo.dao.QuotesDao;
import me.xerosoft.pagedemo.entites.QuoteEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Service
public class QuotesService {

    @Autowired
    private QuotesDao quotesDao;

    public Page<QuoteEntity> list(String author, Integer page, Integer size) {

        if (author.isEmpty())
            return quotesDao.findAll(PageRequest.of(page, size));
        else
            return quotesDao.findAllByAuthorContainingIgnoreCase(author, PageRequest.of(page, size));
    }

    public Optional<QuoteEntity> retrieve(Long id) {
        return quotesDao.findById(id);
    }
}
